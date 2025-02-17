package Module;
import lombok.*;
import java.util.List;



@Builder
@ToString
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Data


public class Question {
    private int id;
    private String questionText;
    private String questionType;
    private String correctAnswer;
    private String imagePath;
    private String audioPath;
    private List<String> options;

    public Question(int i, String questionText, String questionType, String correctAnswer, String imagePath, String audioPath) {
        this.id = i;
        this.questionText = questionText;
        this.questionType = questionType;
        this.correctAnswer = correctAnswer;
        this.imagePath = imagePath;
        this.audioPath = audioPath;
    }
}
