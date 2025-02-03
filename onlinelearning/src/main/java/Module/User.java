package Module;

import java.sql.Date;

import lombok.*;

@Builder
@ToString
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Data


public class User {
    private int userId ;
    private String userName ;
    private String firstName ;
    private String lastName ;
    private String password ;
    private String email ;
    private String phoneNumber ;
    private Date createDate ;
    private boolean gender ;
    private String avatar ;
    private int age ;
    private Role role ;
    private boolean status ;
}
