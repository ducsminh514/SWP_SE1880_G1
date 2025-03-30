package Controller.ForCourse;

import DAO.LessonDAO;
import DAO.LessonTextDAO;
import DAO.LessonVideoDAO;
import DAO.LessonFileDAO;
import DAO.LessonQuizDAO;
import Module.Lesson;
import Module.LessonText;
import Module.LessonVideo;
import Module.Question;
import Module.LessonFile;
import Module.LessonQuiz;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import DAO.QuestionDAO;
import Module.QuestionAnswer;
import DAO.QuestionAnswerDAO;
import java.util.Map;
import java.util.HashMap;
import DAO.SubjectDAO;
import Module.Subject;
import DAO.CourseDAO;
import Module.Course;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import DAO.QuizAttendDAO;
import Module.QuizAttend;
import DAO.EnrollmentDAO;
import DAO.UserDAO;
import Module.User;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LessonContentServlet", urlPatterns = {"/lesson", "/submit-quiz"})
public class LessonContentServlet extends HttpServlet {

    private QuestionDAO questionDAO;
    private QuestionAnswerDAO questionAnswerDAO;
    private LessonDAO lessonDAO;
    private SubjectDAO subjectDAO;
    private CourseDAO courseDAO;
    private LessonQuizDAO lessonQuizDAO;

    @Override
    public void init() throws ServletException {
        questionDAO = new QuestionDAO();
        questionAnswerDAO = new QuestionAnswerDAO();
        lessonDAO = new LessonDAO();
        subjectDAO = new SubjectDAO();
        courseDAO = new CourseDAO();
        lessonQuizDAO = new LessonQuizDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set response content type
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        // Get user ID from session - Cải tiến: lấy userId từ session attribute "account" giống CourseDetailLearningServlet
        int userId = -1;
        HttpSession session = request.getSession();
        try {
            // Get user object from session
            Object userObj = session.getAttribute("account");
            if (userObj != null && userObj instanceof User) {
                User user = (User) userObj;
                userId = user.getUserId();
            }
            // If we can't get userId from user object, keep default userId as -1
        } catch (Exception e) {
            System.out.println("Error getting userId from user object: " + e.getMessage());
            // Continue with default userId -1
        }

        // Initialize progress tracking
        // Since we don't have a LessonCompletion table, we'll use QuizAttend to track completed quizzes
        // and Process_Percentage from Enrollments for overall progress
        Set<Integer> completedLessonIds = new HashSet<>();
        if (userId > 0) {
            // Get completed quizzes from QuizAttend
            QuizAttendDAO quizAttendDAO = new QuizAttendDAO();
            completedLessonIds = getCompletedLessonIdsFromQuizzes(userId, quizAttendDAO);
        }

        // Get lesson ID from request
        String lessonIdStr = request.getParameter("lessonId");
        PrintWriter out = response.getWriter();

        try {
            int lessonId = Integer.parseInt(lessonIdStr);

            // Get lesson details
            Lesson lesson = lessonDAO.findById(lessonId);

            if (lesson == null) {
                out.print("<div class='alert alert-danger'>Lesson not found</div>");
                return;
            }

            // Get the subject and course information
            Subject subject = subjectDAO.getSubjectById(lesson.getSubjectId());
            Course course = courseDAO.getCourseById(subject.getCourse().getCourseId());
            List<Subject> listSubject = subjectDAO.findByCourse(course.getCourseId());

            // Build subject lessons map
            Map<Integer, ArrayList<Lesson>> subjectLessonsMap = new HashMap<>();
            int totalLessons = 0;
            int totalDuration = 0;

            // Populate the map with lessons for each subject
            for (Subject objSubject : listSubject) {
                ArrayList<Lesson> lessons = lessonDAO.getBySubject(objSubject.getSubjectId());

                // Mark completed lessons (using data from quizzes)
                for (Lesson lessonObj : lessons) {
                    if (completedLessonIds.contains(lessonObj.getLessonId())) {
                        lessonObj.setCompleted(true);
                    }
                }

                subjectLessonsMap.put(objSubject.getSubjectId(), lessons);

                // Calculate totals
                totalLessons += lessons.size();
                for (Lesson object : lessons) {
                    totalDuration += object.getDuration();
                }
            }

            // Generate HTML content based on lesson type
            String lessonType = lesson.getType();

            if (lessonType != null) {
                switch (lessonType.toLowerCase()) {
                    case "text":
                        // Get text content
                        LessonTextDAO textDAO = new LessonTextDAO();
                        LessonText text = textDAO.getLessonTextByLessonId(lessonId);
                        if (text != null) {
                            // Set text content as request attribute
                            request.setAttribute("lessonText", text);
                            request.setAttribute("lesson", lesson);
                        }
                        break;

                    case "video":
                        // Get video details
                        LessonVideoDAO videoDAO = new LessonVideoDAO();
                        LessonVideo video = videoDAO.getLessonVideoByLessonId(lessonId);
                        if (video != null) {
                            // Set video as request attribute
                            request.setAttribute("lessonVideo", video);
                            request.setAttribute("lesson", lesson);
                        }
                        break;

                    case "file":
                        // Get file details
                        LessonFileDAO fileDAO = new LessonFileDAO();
                        LessonFile file = fileDAO.getLessonFileByLessonId(lessonId);
                        if (file != null) {
                            // Set file as request attribute
                            request.setAttribute("lessonFile", file);
                            request.setAttribute("lesson", lesson);
                        }
                        break;

                    case "quiz":
                        //process quiz
                        processQuiz(lessonId, request, response);
                        return;
                    default:
                        // Just set the lesson content
                        request.setAttribute("lessonContent", lesson.getContent());
                        request.setAttribute("lesson", lesson);
                        break;
                }
            }

            // Set common attributes for all lesson types
            request.setAttribute("course", course);
            request.setAttribute("listSubject", listSubject);
            request.setAttribute("subjectLessonsMap", subjectLessonsMap);
            request.setAttribute("totalLessons", totalLessons);
            request.setAttribute("totalDuration", totalDuration);

            // Forward to JSP
            request.getRequestDispatcher("CourseDetailUser.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading lesson content: " + e.getMessage());
            request.getRequestDispatcher("CourseDetailUser.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();

        // Handle quiz submissions
        if (uri.contains("/submit-quiz")) {
            handleQuizSubmission(request, response);
            return;
        }

        // Handle marking lesson as completed
        response.setContentType("application/json");
        JsonObject result = new JsonObject();
        PrintWriter out = response.getWriter();

        try {
            // Get lesson ID and user ID
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            int userId = -1;

            // Cải tiến: Lấy userId từ session attribute "account" nhất quán
            HttpSession session = request.getSession();
            try {
                // Get user object from session
                Object userObj = session.getAttribute("account");
                if (userObj != null && userObj instanceof User) {
                    User user = (User) userObj;
                    userId = user.getUserId();
                }
            } catch (Exception e) {
                System.out.println("Error getting userId from user object: " + e.getMessage());
            }

            if (userId <= 0) {
                result.addProperty("success", false);
                result.addProperty("message", "You must be logged in to mark lessons as completed");
                out.print(result.toString());
                return;
            }

            // Get the lesson to find the course
            Lesson lesson = lessonDAO.findById(lessonId);
            if (lesson == null) {
                result.addProperty("success", false);
                result.addProperty("message", "Lesson not found");
                out.print(result.toString());
                return;
            }

            Subject subject = subjectDAO.getSubjectById(lesson.getSubjectId());
            Course course = courseDAO.getCourseById(subject.getCourse().getCourseId());

            // Update the enrollment progress
            updateEnrollmentProgress(userId, course.getCourseId());

            // Return success
            result.addProperty("success", true);
            result.addProperty("message", "Lesson marked as completed");

        } catch (NumberFormatException e) {
            result.addProperty("success", false);
            result.addProperty("message", "Invalid lesson ID format");
            e.printStackTrace();
        } catch (Exception e) {
            result.addProperty("success", false);
            result.addProperty("message", "Error marking lesson as completed: " + e.getMessage());
            e.printStackTrace();
        }

        // Send JSON response
        out.print(result.toString());
    }

    private void processQuiz(int lessonId, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get quiz details
        LessonQuizDAO quizDAO = new LessonQuizDAO();
        LessonQuiz quiz = quizDAO.getByLessonId(lessonId);

        //get lesson by id
        Lesson lesson = lessonDAO.findById(lessonId);
        //get course id
        Subject subject = subjectDAO.getSubjectById(lesson.getSubjectId());
        Course course = courseDAO.getCourseById(subject.getCourse().getCourseId());

        //get all subjects
        List<Subject> listSubject = subjectDAO.findByCourse(course.getCourseId());

        //set request
        request.setAttribute("course", course);
        request.setAttribute("listSubject", listSubject);

        Map<Integer, ArrayList<Lesson>> subjectLessonsMap = new HashMap<>();
        int totalLessons = 0;
        int totalDuration = 0;
        // Populate the map with lessons for each subject
        for (Subject objSubject : listSubject) {
            ArrayList<Lesson> lessons = lessonDAO.getBySubject(objSubject.getSubjectId());

            // // Mark completed lessons
            // for (Lesson lesson : lessons) {
            //     if (completedLessonIds.contains(lesson.getLessonId())) {
            //         lesson.setCompleted(true);
            //     }
            // }

            subjectLessonsMap.put(objSubject.getSubjectId(), lessons);

            // Calculate totals
            totalLessons += lessons.size();
            for (Lesson object : lessons) {
                totalDuration += object.getDuration();
            }
        }

        request.setAttribute("subjectLessonsMap", subjectLessonsMap);
        request.setAttribute("totalLessons", totalLessons);
        request.setAttribute("totalDuration", totalDuration);

        if (quiz != null) {
            // Get quiz questions
            List<Question> questions = questionDAO.getByQuizId(quiz.getLessonQuizID());
            if (questions != null && !questions.isEmpty()) {
                // Create a map of question ID to list of answers
                Map<Integer, List<QuestionAnswer>> questionAnswersMap = new HashMap<>();

                // Separate questions by type
                List<Question> multipleChoiceQuestions = new ArrayList<>();
                List<Question> essayQuestions = new ArrayList<>();

                for (Question question : questions) {
                    // Get answers for this question
                    List<QuestionAnswer> answers = questionAnswerDAO.getAnswerByQuestionId(question.getQuestionId());
                    questionAnswersMap.put(question.getQuestionId(), answers);

                    // Categorize questions by type
                    if (question.getQuestionType().getQuestionTypeId() == 1) {
                        multipleChoiceQuestions.add(question);
                    } else if (question.getQuestionType().getQuestionTypeId() == 2) {
                        essayQuestions.add(question);
                    }
                }

                request.setAttribute("questions", questions);
                request.setAttribute("multipleChoiceQuestions", multipleChoiceQuestions);
                request.setAttribute("essayQuestions", essayQuestions);
                request.setAttribute("questionAnswersMap", questionAnswersMap);
                request.setAttribute("quiz", quiz);
                request.getRequestDispatcher("CourseDetailUser.jsp").forward(request, response);
            }
        }
    }

    /**
     * Handles quiz submission from the form
     */
    private void handleQuizSubmission(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject result = new JsonObject();

        try {
            // Log all parameters for debugging
            Map<String, String[]> params = request.getParameterMap();
            System.out.println("All parameters received:");
            for (Map.Entry<String, String[]> entry : params.entrySet()) {
                System.out.println(entry.getKey() + ": " + String.join(", ", entry.getValue()));
            }

            // Get lesson ID from the form
            String lessonIdParam = request.getParameter("lessonId");
            System.out.println("lessonId parameter: " + lessonIdParam);

            if (lessonIdParam == null || lessonIdParam.trim().isEmpty()) {
                result.addProperty("success", false);
                result.addProperty("message", "Lesson ID is missing");
                out.print(result.toString());
                return;
            }

            int lessonId = Integer.parseInt(lessonIdParam);

            // Get the quiz for this lesson
            LessonQuiz quiz = lessonQuizDAO.getByLessonId(lessonId);
            if (quiz == null) {
                result.addProperty("success", false);
                result.addProperty("message", "Quiz not found");
                out.print(result.toString());
                return;
            }

            // Get all questions for this quiz
            List<Question> questions = questionDAO.getByQuizId(quiz.getLessonQuizID());
            if (questions == null || questions.isEmpty()) {
                result.addProperty("success", false);
                result.addProperty("message", "No questions found for this quiz");
                out.print(result.toString());
                return;
            }

            // Process user answers
            Map<Integer, List<Integer>> multipleChoiceAnswers = new HashMap<>();
            Map<Integer, String> essayAnswers = new HashMap<>();
            Map<String, String[]> parameterMap = request.getParameterMap();

            // Extract user answers from request parameters
            for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
                String paramName = entry.getKey();

                // Check if parameter is a question answer (format: question_<questionId>)
                if (paramName.startsWith("question_")) {
                    try {
                        // Extract question ID from parameter name
                        int questionId = Integer.parseInt(paramName.substring("question_".length()));
                        String[] answerValues = entry.getValue();

                        // Get the question to determine its type
                        Question question = null;
                        for (Question q : questions) {
                            if (q.getQuestionId() == questionId) {
                                question = q;
                                break;
                            }
                        }

                        if (question != null) {
                            // Process based on question type
                            if (question.getQuestionType().getQuestionTypeId() == 1) {
                                // Multiple choice question - parse answer IDs
                                List<Integer> answerIds = new ArrayList<>();
                                for (String answerValue : answerValues) {
                                    try {
                                        answerIds.add(Integer.parseInt(answerValue));
                                    } catch (NumberFormatException e) {
                                        // Skip invalid answer values
                                        System.out.println("Invalid answer value: " + answerValue);
                                    }
                                }
                                multipleChoiceAnswers.put(questionId, answerIds);
                            } else if (question.getQuestionType().getQuestionTypeId() == 2) {
                                // Essay/fill-in-the-blank question - store text directly
                                essayAnswers.put(questionId, answerValues[0]);
                            }
                        }
                    } catch (NumberFormatException e) {
                        // This happens if the question ID part isn't a valid integer
                        System.out.println("Invalid question parameter: " + paramName);
                    }
                }
            }

            // Calculate score for multiple choice questions
            int totalQuestions = questions.size();
            int correctAnswers = 0;

            for (Question question : questions) {
                int questionId = question.getQuestionId();

                // Process based on question type
                if (question.getQuestionType().getQuestionTypeId() == 1) {
                    // Multiple choice question
                    List<QuestionAnswer> correctAnswersList = questionAnswerDAO.getCorrectAnswersByQuestionId(questionId);
                    Set<Integer> correctAnswerIds = new HashSet<>();
                    for (QuestionAnswer answer : correctAnswersList) {
                        correctAnswerIds.add(answer.getAnswerId());
                    }

                    // Get user's answers for this question
                    List<Integer> userAnswerIds = multipleChoiceAnswers.get(questionId);

                    // If user didn't answer this question
                    if (userAnswerIds == null || userAnswerIds.isEmpty()) {
                        continue;
                    }

                    // Check if user's answers match correct answers
                    Set<Integer> userAnswerSet = new HashSet<>(userAnswerIds);

                    // For single-choice questions (radio buttons)
                    if (correctAnswerIds.size() == 1) {
                        if (correctAnswerIds.containsAll(userAnswerSet)) {
                            correctAnswers++;
                        }
                    }
                    // For multiple-choice questions (checkboxes)
                    else {
                        // All selected answers must be correct and all correct answers must be selected
                        if (correctAnswerIds.equals(userAnswerSet)) {
                            correctAnswers++;
                        }
                    }
                }
                // For essay/fill-in-the-blank questions (type 2)
                else if (question.getQuestionType().getQuestionTypeId() == 2) {
                    // Get user's answer for this question
                    String userAnswer = essayAnswers.get(questionId);

                    // If user didn't answer this question
                    if (userAnswer == null || userAnswer.trim().isEmpty()) {
                        continue;
                    }

                    // Get correct answers for this question
                    List<QuestionAnswer> correctAnswersList = questionAnswerDAO.getCorrectAnswersByQuestionId(questionId);

                    // Check if any of the correct answers match the user's answer (case insensitive)
                    boolean isCorrect = false;
                    for (QuestionAnswer answer : correctAnswersList) {
                        if (userAnswer.trim().equalsIgnoreCase(answer.getContent().trim())) {
                            isCorrect = true;
                            break;
                        }
                    }

                    if (isCorrect) {
                        correctAnswers++;
                    }
                }
            }

            // Calculate percentage score
            double scorePercentage = (double) correctAnswers / totalQuestions * 100;
            int roundedScore = (int) Math.round(scorePercentage);

            // Check if user passed the quiz
            boolean passed = scorePercentage >= quiz.getPassPercentage();

            // Prepare result JSON
            result.addProperty("success", true);
            result.addProperty("score", roundedScore);
            result.addProperty("correctAnswers", correctAnswers);
            result.addProperty("totalQuestions", totalQuestions);
            result.addProperty("passed", passed);

            if (passed) {
                result.addProperty("message", "Congratulations! You passed the quiz.");

                // TODO: Mark lesson as completed in the database
                // markLessonAsCompleted(lessonId, userId);
            } else {
                result.addProperty("message", "You did not pass the quiz. Required: " +
                        quiz.getPassPercentage() + "%, Your score: " + roundedScore + "%");
            }

        } catch (NumberFormatException e) {
            result.addProperty("success", false);
            result.addProperty("message", "Invalid lesson ID format: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            result.addProperty("success", false);
            result.addProperty("message", "Error processing quiz: " + e.getMessage());
            e.printStackTrace();
        }

        // Send JSON response
        out.print(result.toString());
    }
    /**
     * Updates the enrollment progress based on completed quizzes
     */
    private void updateEnrollmentProgress(int userId, int courseId) {
        try {
            // Get all lessons for this course
            EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
            SubjectDAO subjectDAO = new SubjectDAO();
            LessonDAO lessonDAO = new LessonDAO();
            QuizAttendDAO quizAttendDAO = new QuizAttendDAO();

            // Get all subjects for this course
            List<Subject> subjects = subjectDAO.findByCourse(courseId);
            int totalLessons = 0;
            int completedLessons = 0;

            // Count total lessons and completed lessons
            for (Subject subject : subjects) {
                ArrayList<Lesson> lessons = lessonDAO.getBySubject(subject.getSubjectId());
                totalLessons += lessons.size();

                // Check each lesson
                for (Lesson lesson : lessons) {
                    // For video lessons, we don't have completion tracking
                    // For quiz lessons, check if the user has passed
                    if ("quiz".equalsIgnoreCase(lesson.getType())) {
                        LessonQuiz quiz = lessonQuizDAO.getByLessonId(lesson.getLessonId());
                        if (quiz != null) {
                            List<QuizAttend> attempts = quizAttendDAO.getPassedQuizzesByUser(userId, quiz.getLessonQuizID());
                            if (attempts != null && !attempts.isEmpty()) {
                                completedLessons++;
                            }
                        }
                    }
                }
            }

            // Calculate progress percentage
            int progressPercentage = 0;
            if (totalLessons > 0) {
                progressPercentage = (completedLessons * 100) / totalLessons;
            }

            // Update enrollment record
            enrollmentDAO.updateProgress(userId, courseId, String.valueOf(progressPercentage));

        } catch (Exception e) {
            System.err.println("Error updating enrollment progress: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Gets the set of lesson IDs that have been completed by the user based on quiz attempt data
     */
    private Set<Integer> getCompletedLessonIdsFromQuizzes(int userId, QuizAttendDAO quizAttendDAO) {
        Set<Integer> completedLessonIds = new HashSet<>();

        try {
            // Get all lesson quizzes
            List<LessonQuiz> quizzes = lessonQuizDAO.findAll();

            // For each quiz, check if the user has passed it
            for (LessonQuiz quiz : quizzes) {
                List<QuizAttend> attempts = quizAttendDAO.getPassedQuizzesByUser(userId, quiz.getLessonQuizID());
                if (attempts != null && !attempts.isEmpty()) {
                    // If there are passed attempts, add the lesson ID to the completed set
                    completedLessonIds.add(quiz.getLesson().getLessonId());
                }
            }
        } catch (Exception e) {
            System.err.println("Error getting completed lesson IDs: " + e.getMessage());
            e.printStackTrace();
        }

        return completedLessonIds;
    }
}
