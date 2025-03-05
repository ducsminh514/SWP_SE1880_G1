package Module;

import java.util.Date;

public class User {
    private int userId ;
    private String userName ;
    private String firstName ;
    private String lastName ;
    private String password ;
    private String email ;
    private String phoneNumber ;
    private Date createDate ;
    private String gender ;
    private String avatar ;
    private int age ;
    private Role role ;
    private boolean status ;


    public User() {
    }

    public User(int userId, String userName, String firstName, String lastName, String password, String email, String phoneNumber, Date createDate, String gender, String avatar, int age,Role role, boolean status) {
        this.userId = userId;
        this.userName = userName;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.createDate = createDate;
        this.gender = gender;
        this.avatar = avatar;
        this.age = age;
        this.role = role;
        this.status = status;
    }

    public User(String userName, String firstName, String lastName, String password, String email, String phoneNumber, String gender, String avatar, int age, Role role, boolean status) {
        this.userName = userName;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.avatar = avatar;
        this.age = age;
        this.role = role;
        this.status = status;
    }

    public User(String firstName, String lastName, String email, String phoneNumber, String gender, int age, int userId) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.age = age;
        this.userId = userId;
    }

    public User(String userName, String firstName, String lastName, String email, String phoneNumber, String gender,String avatar,int userId) {
        this.userName = userName;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.avatar = avatar;
        this.userId = userId;
    }

    public User(int userId) {
        this.userId = userId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
