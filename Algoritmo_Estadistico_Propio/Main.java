import java.io.*;
import java.sql.ResultSet;
import java.util.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import java.sql.Statement;


public class Main{

    private int userId;
    private Usuario user;
    
    public void setUser(int id, Usuario us) throws Exception {
            userId = id;
            user = us;
    }

    public int getUserId() {
        return userId;
    } 

    public Usuario getUser() {
        return user;
    } 
    
    public static void main(String[] args) {
        try {
            Main a = new Main();
            Scanner scanner = new Scanner(System.in);

            System.out.println("\t BeTrend \t");

            System.out.println("Do you want to sign in (1) or sign up (2)?");
            System.out.print("Enter number: ");
            String result = scanner.nextLine();
            System.out.println();

            if (result.equals("1")) {
                System.out.println("Sign in (please insert your email and password):");

                System.out.print("Email: ");
                String emailInput = scanner.nextLine();

                System.out.print("Password: ");
                String passwordInput = scanner.nextLine();

                Usuario b = new Usuario(emailInput, passwordInput);
                int id = b.signIn();
                a.setUser(id, b);

            } else if (result.equals("2")) {
                System.out.println("Sign up (please insert the following information):");

                System.out.print("First Name (Ej: Micaela): ");
                String nameInput = scanner.nextLine();

                System.out.print("Last Name (Ej: Sanchez): ");
                String lastInput = scanner.nextLine();

                System.out.print("Country (Ej: EC): ");
                String countryInput = scanner.nextLine();

                System.out.print("Email (Ej: micaela@gmail.com): ");
                String emailInput = scanner.nextLine();

                System.out.print("Password (Ej: micaela1234): ");
                String passwordInput = scanner.nextLine();

                System.out.print("Spotify Account (Ej: micaela@spotify.com): ");
                String spotifyInput = scanner.nextLine();

                Usuario b = new Usuario(nameInput, lastInput, emailInput, passwordInput, countryInput, spotifyInput);

                System.out.print("I agree to the terms of Services and Privacy Policy: Yes (Y) or No (N): ");
                String agreeInput = scanner.nextLine();

                if (agreeInput.equals("Y")) {
                    int id = b.signUp();
                    a.setUser(id,b);
                } else if (agreeInput.equals("N")) {
                    System.out.println("You cannot continue.");
                    return;
                } else {
                    System.out.println("Incorrect input value.");
                    System.exit(1);
                }

            } else {
                System.out.println("Incorrect input value.");
                return;
            }

            boolean continuar = true;

            while (continuar) {
                System.out.println();
                System.out.println("\t \t Menu");
                System.out.println("Do you want to Upload Music (1), See Profile (2) or Log Out (3)?");
                System.out.print("Enter number: ");
                String result2 = scanner.nextLine();
                System.out.println();

                if (result2.equals("1")) {
                    System.out.println("\t \t Upload Music");

                    System.out.println("Will I be a trend?");
                    System.out.print("Enter the name of the song: ");
                    String nameSong = scanner.nextLine();
                    a.getUser().Music(nameSong);

                    System.out.println();
                    System.out.print("Do you want to go to Menu or Log Out? Menu (M) or Log Out (L): ");
                    String result3 = scanner.nextLine();
                    System.out.println();

                    if (!result3.equalsIgnoreCase("M")) {
                        System.out.println("Have a good day! Bye.");
                        continuar = false;
                    }

                } else if (result2.equals("2")) {
                    System.out.println("\t \t Profile");
                    a.getUser().Profile();

                    System.out.println("\nDo you want more details of any song?");
                    System.out.print("Enter the name of the song: ");
                    String nameSong = scanner.nextLine();
                    a.getUser().Music(nameSong);

                    System.out.println();
                    System.out.print("Do you want to go to Menu or Log Out? Menu (M) or Log Out (L): ");
                    String result3 = scanner.nextLine();
                    System.out.println();

                    if (!result3.equalsIgnoreCase("M")) {
                        System.out.println("Have a good day! Bye.");
                        continuar = false;
                    }

                } else if (result2.equals("3")) {
                    System.out.println("Have a good day! Bye. ");
                    continuar = false;
                } else {
                    System.out.println("Incorrect input value.");
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}