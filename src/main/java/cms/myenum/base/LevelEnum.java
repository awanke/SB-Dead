package cms.myenum.base;

public enum LevelEnum implements GenericEnum {
    LOW(0, "低"), MIDDLE(1, "中"), HIGH(2, "高");

    private int code;
    private String name;

    LevelEnum(int code, String name) {
        this.code = code;
        this.name = name;
    }

    public int getCode() {
        return this.code;
    }

    public String getName() {
        return this.name;
    }

    public static LevelEnum valueOfEnum(int code) {
        LevelEnum[] iss = values();
        for (LevelEnum cs : iss) {
            if (cs.getCode() == code) {
                return cs;
            }
        }
        return null;
    }
}