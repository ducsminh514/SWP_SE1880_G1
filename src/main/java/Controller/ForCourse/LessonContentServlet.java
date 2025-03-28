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

        // Get lesson ID from request
        String lessonIdStr = request.getParameter("lessonId");
        PrintWriter out = response.getWriter();

        // if (lessonIdStr == null || lessonIdStr.isEmpty()) {
        //     out.print("<div class='alert alert-danger'>Lesson ID is required</div>");
        //     return;
        // }

        try {
            int lessonId = Integer.parseInt(lessonIdStr);

            // Get lesson details
            LessonDAO lessonDAO = new LessonDAO();
            Lesson lesson = lessonDAO.findById(lessonId);

            if (lesson == null) {
                out.print("<div class='alert alert-danger'>Lesson not found</div>");
                return;
            }

            // Generate HTML content based on lesson type
            String lessonType = lesson.getType();
            StringBuilder htmlContent = new StringBuilder();

            if (lessonType != null) {
                switch (lessonType.toLowerCase()) {
                    case "text":
                        // Get text content
                        LessonTextDAO textDAO = new LessonTextDAO();
                        LessonText text = textDAO.getLessonTextByLessonId(lessonId);
                        if (text != null) {
                            htmlContent.append("<div class='lesson-content'>");
                            htmlContent.append(text.getContent());
                            htmlContent.append("</div>");
                        }
                        break;

                    case "video":
                        // Get video details
                        LessonVideoDAO videoDAO = new LessonVideoDAO();
                        LessonVideo video = videoDAO.getLessonVideoByLessonId(lessonId);
                        if (video != null) {
                            htmlContent.append("<div class='video-container mb-4'>");
                            htmlContent.append("<iframe src='").append(video.getVideoUrl()).append("' allowfullscreen></iframe>");
                            htmlContent.append("</div>");

                            if (video.getTranscript() != null && !video.getTranscript().isEmpty()) {
                                htmlContent.append("<div class='transcript-container'>");
                                htmlContent.append("<h5>Transcript</h5>");
                                htmlContent.append("<div class='transcript-content'>").append(video.getTranscript()).append("</div>");
                                htmlContent.append("</div>");
                            }
                        }
                        break;

                    case "file":
                        // Get file details
                        LessonFileDAO fileDAO = new LessonFileDAO();
                        LessonFile file = fileDAO.getLessonFileByLessonId(lessonId);
                        if (file != null) {
                            htmlContent.append("<div class='file-container'>");
                            htmlContent.append("<h5>Download Resource</h5>");
                            htmlContent.append("<p>File Type: ").append(file.getFileType()).append("</p>");
                            htmlContent.append("<p>File Size: ").append(file.getFileSize()).append(" KB</p>");
                            htmlContent.append("<a href='").append(file.getFileUrl()).append("' class='btn' download>");
                            htmlContent.append("<i class='fa fa-download'></i> Download File</a>");
                            htmlContent.append("</div>");
                        }
                        break;

                    case "quiz":
                        //process quiz
                        processQuiz(lessonId, request, response);
                        break;
                    default:
                        htmlContent.append("<div class='lesson-content'>");
                        htmlContent.append(lesson.getContent());
                        htmlContent.append("</div>");
                        break;
                }
            } else {
                // If no specific type, use the general content
                htmlContent.append("<div class='lesson-content'>");
                htmlContent.append(lesson.getContent());
                htmlContent.append("</div>");
            }

            // Add completion button
            // htmlContent.append("<div class='mt-4 text-right'>");
            // htmlContent.append("<button class='btn' onclick='markLessonAsCompleted(").append(lessonId).append(")'>");
            // htmlContent.append("<i class='fa fa-check-circle'></i> Mark as Completed</button>");
            // htmlContent.append("</div>");

            // Send the response
            // out.print(htmlContent.toString());

        } catch (NumberFormatException e) {
            // out.print("<div class='alert alert-danger'>Invalid lesson ID</div>");
            e.printStackTrace();
        } catch (Exception e) {
            // out.print("<div class='alert alert-danger'>Error loading lesson content: " + e.getMessage() + "</div>");
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String servletPath = request.getServletPath();
        
        if ("/submit-quiz".equals(servletPath)) {
            handleQuizSubmission(request, response);
        } else {
            doGet(request, response);
        }
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
}
