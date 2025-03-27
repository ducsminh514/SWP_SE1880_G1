/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package subjectlessons;

/**
 *
 * @author Admin
 */
public class Lesson {
    private int lessonID;
    private int subjectID;
    private String lessonName;
    private boolean status;

    public Lesson() {}

    public Lesson(int lessonID, int subjectID, String lessonName, boolean status) {
        this.lessonID = lessonID;
        this.subjectID = subjectID;
        this.lessonName = lessonName;
        this.status = status;
    }

    public int getLessonID() { return lessonID; }
    public void setLessonID(int lessonID) { this.lessonID = lessonID; }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    
    public String getLessonName() { return lessonName; }
    public void setLessonName(String lessonName) { this.lessonName = lessonName; }
    
    public boolean getStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
}
