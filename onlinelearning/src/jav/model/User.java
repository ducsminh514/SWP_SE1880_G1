package jav.model;

public class User {
//    UserID INT PRIMARY KEY IDENTITY(1,1),
//    Username NVARCHAR(50) NOT NULL,
//    Fullname NVARCHAR(100) NOT NULL,
//    Password NVARCHAR(255) NOT NULL,
//    Email NVARCHAR(100) NOT NULL,
//    PhoneNumber NVARCHAR(12) NOT NULL,
//    CreatedDate DATETIME DEFAULT GETDATE(),
//    Age int NOT NULL,
//    RoleID INT,
//    Status bit ,
//    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
    private int UserID;
    private String Username, Fullname, Password,Email,PhoneNumber,CreatedDate;
    private int Age, RoleID;
    private boolean status;

    public User() {
    }

    public User(int userID, String username, String fullname, String password, String email, String phoneNumber, String createdDate, int age, int roleID, boolean status) {
        UserID = userID;
        Username = username;
        Fullname = fullname;
        Password = password;
        Email = email;
        PhoneNumber = phoneNumber;
        CreatedDate = createdDate;
        Age = age;
        RoleID = roleID;
        this.status = status;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int userID) {
        UserID = userID;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        Username = username;
    }

    public String getFullname() {
        return Fullname;
    }

    public void setFullname(String fullname) {
        Fullname = fullname;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        PhoneNumber = phoneNumber;
    }

    public String getCreatedDate() {
        return CreatedDate;
    }

    public void setCreatedDate(String createdDate) {
        CreatedDate = createdDate;
    }

    public int getAge() {
        return Age;
    }

    public void setAge(int age) {
        Age = age;
    }

    public int getRoleID() {
        return RoleID;
    }

    public void setRoleID(int roleID) {
        RoleID = roleID;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
