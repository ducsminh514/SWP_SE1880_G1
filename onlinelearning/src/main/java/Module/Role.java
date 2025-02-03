package Module;

public class Role {
    private int roleId ;
    private String roleName ;

    public Role(int roleId, String roleName) {
        this.roleId = roleId;
        this.roleName = roleName;
    }
    public Role(int roleId) {
       switch(roleId){
           case 1:
               this.roleId = 1;
               roleName = "Admin";
           break;
           case 2:
               this.roleId = 2;
               roleName = "Expert";
           break;
           case 3:
               this.roleId = 3;
               roleName = "Marketing";
           break;
           case 4:
               this.roleId = 4;
               roleName = "Sales";
           break;
           case 5:
               this.roleId = 4;
               roleName = "Customer";
               break;
       }
    }


    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
