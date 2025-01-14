import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);

        System.out.println("Ввести m > 1");
        System.out.println("m = ");

        int m = in.nextInt();

        if (m <= 1){
            System.out.println("Должно быть больше 1");
            return;
        }

        if (m > 1){
            int k = findMaxK(m);
            System.out.println("Наибольшее значение k = " + k);
        }

    }

    private static int findMaxK(int m){
        int k = 0;

        while (Math.pow(4, k+1) < m){
            k++;
        }
        return k;
    }
}