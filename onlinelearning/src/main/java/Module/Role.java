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
           case 1: roleName = "Admin";
           case 2: roleName = "Expert";
           case 3: roleName = "Marketing";
           case 4: roleName = "Sales";
           case 5: roleName = "Customer";
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
