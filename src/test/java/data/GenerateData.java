package data;

public class GenerateData {
    public static String getEmail(){
        int random = (int)(Math.random() * 1000000000);
        return "Mori" + random + "@gmail.com";
    }
    public static String allCaps(String input){
        return input.toUpperCase();
    }
}
