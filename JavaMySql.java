import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Properties;
import java.sql.CallableStatement;
import java.util.Scanner;


public class JavaMySql {

  // The name of the MySQL account to use
  private final String userName = "username";

  // The password for the MySQL account
  private final String password = "password";

  // The name of the computer running MySQL 
  private final String serverName = "localhost";

  // The port of the MySQL server (default is 3306) 
  private final int portNumber = 3306;

  // The name of the database we are testing with (this default is installed with MySQL) 
  private final String dbName = "videogames";

  // The name of the table we are testing with 
  private final String tableName = "JDBC_TEST";
  private final boolean useSSL = false;


  /**
   * Get a new database connection
   * 
   * @return
   * @throws SQLException
   */
  public Connection getConnection() throws SQLException {
    Connection conn = null;
    Properties connectionProps = new Properties();
    connectionProps.put("user", this.userName);
    connectionProps.put("password", this.password);

    conn = DriverManager.getConnection("jdbc:mysql://"
        + this.serverName + ":" + this.portNumber + "/" + this.dbName + "?characterEncoding=UTF-8&useSSL=false",
        connectionProps);

    return conn;
  }
  /**
   * Connect to MySQL
   * @throws SQLException 
   */
  String sql_username2;
  String sql_password2;
  public void run() throws SQLException {
    // Connect to MySQL
    Connection conn = null;
    try {
      conn = this.getConnection();
      System.out.println("Connected to database");
    } catch (SQLException e) {
      System.out.println("ERROR: Could not connect to the database");
      e.printStackTrace();
      return;
    }
    try{
      // Scanner object for user input
      Scanner myObj = new Scanner(System.in);
      // Checks if you have an account
      System.out.println("Have you created an account? (Yes or No)");
      String response;
      response = myObj.nextLine();
      while(!response.equals("Yes") && !response.equals("yes") && !response.equals("No")
          && !response.equals("no")) {
        System.out.println("Please enter yes or no");
        System.out.println("Have you created an account? (Yes or No)");
        response = myObj.nextLine();
      }
      // Account creation
      if(response.equals("No") || response.equals("no")) {
        System.out.println("Are you an admin or regular user?");
        String user;
        user = myObj.nextLine();
        // Account creation for administrator
        if(user.equals("admin") || user.equals("Admin")) {
          String sql_username;
          String sql_password;
          System.out.println("Enter Username:");
          sql_username = myObj.nextLine();
          System.out.println("Enter Password:");
          sql_password = myObj.nextLine();
          while(true) {
            CallableStatement cst = conn.prepareCall("{? = CALL unique_account(?)}");
            cst.registerOutParameter(1, Types.BOOLEAN);
            cst.setString(2, sql_username);
            ResultSet rst = cst.executeQuery();
            rst.next();
            if(rst.getBoolean(1)) {
              CallableStatement cs = conn.prepareCall("{CALL create_account(?, ?)}");
              cs.setString(1, sql_username);
              cs.setString(2, sql_password);
              cs.executeQuery();
              cs.close();
              System.out.println("Account Created");
              CallableStatement cs2 = conn.prepareCall("{CALL add_admin(?, ?)}");
              cs2.setString(1, sql_username);
              cs2.setString(2, sql_password);
              cs2.execute();
              cs2.close();
              break;
            }
            else if(!rst.getBoolean(1)) {
              System.out.println("Username already taken");
              System.out.println("Please enter again");
              System.out.println("Enter Username:");
              sql_username = myObj.nextLine();
              System.out.println("Enter Password:");
              sql_password = myObj.nextLine();
              continue;
            }   
          }
        }
        // account creation for regular user
        else if(user.equals("Regular") || user.equals("regular")) {
          String sql_username;
          String sql_password;
          System.out.println("Enter Username:");
          sql_username = myObj.nextLine();
          System.out.println("Enter Password:");
          sql_password = myObj.nextLine();
          while(true) {
            CallableStatement cst = conn.prepareCall("{? = CALL unique_account(?)}");
            cst.registerOutParameter(1, Types.BOOLEAN);
            cst.setString(2, sql_username);
            ResultSet rst = cst.executeQuery();
            rst.next();
            if(rst.getBoolean(1)) {
              CallableStatement cs = conn.prepareCall("{CALL create_account(?, ?)}");
              cs.setString(1, sql_username);
              cs.setString(2, sql_password);
              cs.executeQuery();
              cs.close();
              System.out.println("Account Created");
              CallableStatement cs2 = conn.prepareCall("{CALL add_regular(?, ?)}");
              cs2.setString(1, sql_username);
              cs2.setString(2, sql_password);
              cs2.execute();
              cs2.close();
              break;
            }
            else if(!rst.getBoolean(1)) {
              System.out.println("Username already taken");
              System.out.println("Please enter again");
              System.out.println("Enter Username:");
              sql_username = myObj.nextLine();
              System.out.println("Enter Password:");
              sql_password = myObj.nextLine();
              continue;
            }   
          }
        }
        // login for user with a newly created account
        System.out.println("Enter Username:");
        sql_username2 = myObj.nextLine();
        System.out.println("Enter Password:");
        sql_password2 = myObj.nextLine();
        while(true) {
          CallableStatement cs2 = conn.prepareCall("{? = CALL login(?, ?)}");
          cs2.registerOutParameter(1, Types.BOOLEAN);
          cs2.setString(2, sql_username2);
          cs2.setString(3, sql_password2);
          ResultSet rs = cs2.executeQuery();
          rs.next();
          if(!rs.getBoolean(1)) {
            System.out.println("Incorrect Username or Password");
            System.out.println("Enter Username:");
            sql_username2 = myObj.nextLine();
            System.out.println("Enter Password:");
            sql_password2 = myObj.nextLine();
            continue;
          }
          if(rs.getBoolean(1)) {
            System.out.println("Successfully logged in");
            break;
          }
        }
      }
      // Direct login for user that already has account 
      else {
        if(response.equals("Yes") || response.equals("yes")) {
          System.out.println("Enter Username:");
          sql_username2 = myObj.nextLine();
          System.out.println("Enter Password:");
          sql_password2 = myObj.nextLine();
          while(true) {
            CallableStatement cs2 = conn.prepareCall("{? = CALL login(?, ?)}");
            cs2.registerOutParameter(1, Types.BOOLEAN);
            cs2.setString(2, sql_username2);
            cs2.setString(3, sql_password2);
            ResultSet rs = cs2.executeQuery();
            rs.next();
            if(!rs.getBoolean(1)) {
              System.out.println("Incorrect Username or Password");
              System.out.println("Enter Username:");
              sql_username2 = myObj.nextLine();
              System.out.println("Enter Password:");
              sql_password2 = myObj.nextLine();
              continue;
            }
            if(rs.getBoolean(1)) {
              System.out.println("Successfully logged in");
              break;
            }
          }
        }
        else System.out.println("ERROR: Invalid input");
      } 
      // checks if you are a regular user or administrator
      CallableStatement cs2 = conn.prepareCall("{? = CALL check_admin_or_regular(?)}");
      cs2.registerOutParameter(1, Types.VARCHAR);
      cs2.setString(2, sql_username2);
      ResultSet rst = cs2.executeQuery();
      rst.next();
      // asks if admin would like to edit database
      if(rst.getString(1).equals("admin")) {
        String adminpower;
        System.out.println("Would you like to edit the database? (Yes or No)");
        adminpower = myObj.nextLine();
        while(!adminpower.equals("Yes") && !adminpower.equals("yes") && !adminpower.equals("No") && !adminpower.equals("no")) {
          System.out.println("ERROR: Please enter yes or no");
          System.out.println("Would you like to edit the database? (Yes or No)");
          adminpower = myObj.nextLine();
        }
        // asks if admin would like to add or delete game from database
        if(adminpower.equals("Yes") || adminpower.equals("yes")) {
          String adminaddordelete;
          System.out.println("Would you like to add or delete a game from the database? (Yes or No)");
          adminaddordelete = myObj.nextLine();
          while(!adminaddordelete.equals("Yes") && !adminaddordelete.equals("yes") && 
              !adminaddordelete.equals("No") && !adminaddordelete.equals("no")) {
            System.out.println("ERROR: Please enter yes or no");
            System.out.println("Would you like to add or delete a game from the database? (Yes or No)");
            adminaddordelete = myObj.nextLine();
          }
          if(adminaddordelete.equals("Yes") || adminaddordelete.equals("yes")) {
            String sql = "SELECT * FROM game";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            System.out.println("List of games:");
            while(rs.next()) {
              String a = rs.getString(1);
              String b = rs.getString(2);
              String c = rs.getString(3);
              boolean d = rs.getBoolean(4);
              String e = rs.getString(5);
              String f = rs.getString(6);
              System.out.println("ID: " + a + ", " + "Title: " + b + ", " + "Rating: " 
                  + c + ", " + "Competitive?: " + d + ", " + "Genre: " + e + ", " + "Developer: " + f);
            } 
            // asks if admin wants to add or delete
            String adddelete;
            System.out.println("Add or Delete?");
            adddelete = myObj.nextLine();
            while(!adddelete.equals("Add") && !adddelete.equals("add") && !adddelete.equals("Delete") && !adddelete.equals("delete")) {
              System.out.println("ERROR: Please enter yes or no");
              System.out.println("Add or Delete?");
              adddelete = myObj.nextLine();
            }
            // adds game to database
            if(adddelete.equals("Add") || adddelete.equals("add")) {
              System.out.println("Enter data");
              String id;
              String gamename;
              String rating;
              String comp;
              String genre;
              String developer;
              System.out.println("Game id:");
              id = myObj.nextLine();
              System.out.println("Game name:");
              gamename = myObj.nextLine();
              System.out.println("Game rating:");
              rating = myObj.nextLine();
              System.out.println("Competitive?:");
              comp = myObj.nextLine();
              System.out.println("Game genre:");
              genre = myObj.nextLine();
              System.out.println("Game developer:");
              developer = myObj.nextLine();
              CallableStatement cs = conn.prepareCall("{CALL add_to_database(?, ?, ?, ?, ?, ?)}");
              cs.setString(1, id);
              cs.setString(2, gamename);
              cs.setString(3, rating);
              cs.setString(4, comp);
              cs.setString(5, genre);
              cs.setString(6, developer);
              cs.executeQuery();
              cs.close();
              System.out.println("Game successfully added to database");
            }
            // deletes game from database
            else if(adddelete.equals("Delete") || adddelete.equals("delete")) {
              String gamename;
              System.out.println("Enter game name:");
              gamename = myObj.nextLine();
              CallableStatement cs = conn.prepareCall("{CALL delete_from_database(?)}");
              cs.setString(1, gamename);
              System.out.println("Game successfully deleted from database");
            }
          }
          // asks if admin would like to update database
          else if(adminaddordelete.equals("No") || adminaddordelete.equals("no")) {
            System.out.println("Would you like to update the database? (Yes or No)");
            String update;
            update = myObj.nextLine();
            if(update.equals("Yes") || update.equals("yes")) {
              System.out.println("Which game to update? (Give name)");
              String name;
              name = myObj.nextLine();
              String newId;
              System.out.println("New ID:");
              newId = myObj.nextLine();
              String newName;
              System.out.println("New name:");
              newName = myObj.nextLine();
              String newRating;
              System.out.println("New rating:");
              newRating = myObj.nextLine();
              String newComp;
              System.out.println("New Competitive status:");
              newComp = myObj.nextLine();
              String newGenre;
              System.out.println("New genre:");
              newGenre = myObj.nextLine();
              String newDev;
              System.out.println("New developer:");
              newDev = myObj.nextLine();
              CallableStatement cs8 = conn.prepareCall("{CALL update_database(?,?,?,?,?,?,?)}");
              cs8.setString(1, newId);
              cs8.setString(2, newName);
              cs8.setString(3, name);
              cs8.setString(4, newRating);
              cs8.setString(5, newComp);
              cs8.setString(6, newGenre);
              cs8.setString(7, newDev);
              cs8.executeQuery();
              cs8.close();
              System.out.println("Database successfully updated");
            }
          }
        }
        else if(adminpower.equals("No") || adminpower.equals("no")) {
        }
      }
      // regular user doesn't have access to admin privileges, so they skip over
      else if(rst.getString(1).equals("regular")) {
      }
      else if(rst.getString(1).equals("neither")) {
      }
      while(true) {
        // users can choose where to go next
        String next;
        System.out.println("Where would you like to go next?");
        System.out.println("Search bar, Favorites list, Watch list, Recommendations list, Logout, or User trends");
        next = myObj.nextLine();
        while(!next.equals("Search bar") && !next.equals("search bar") && !next.equals("search") && !next.equals("Search")
            && !next.equals("Favorites list") && !next.equals("favorites list") && !next.equals("favorites") && !next.equals("Favorites")
            && !next.equals("Watch list") && !next.equals("watch list") && !next.equals("watch") && !next.equals("Watch")
            && !next.equals("Recommendations list") && !next.equals("recommendations list") && !next.equals("recommendations")
            && !next.equals("Recommendations") && !next.equals("Logout") && !next.equals("logout") && !next.equals("user trends")
            && !next.equals("User trends")) {
          System.out.println("Please enter Search bar, Favorites list, Watch list, Recommendations list, Logout, or User trends");
          System.out.println("Where would you like to go next?");
          System.out.println("Search bar, Favorites list, Watch list, Recommendations list, Logout, or User trends");
          next = myObj.nextLine();
        }
        // search for games 
        if(next.equals("Search bar") || next.equals("Search") || next.equals("search") || next.equals("search bar")) {
          String viewall;
          System.out.println("View all games or search by filter?");
          System.out.println("Enter 'view all' or 'filter':");
          viewall = myObj.nextLine();
          while(!viewall.equals("view all") && !viewall.equals("View all") && !viewall.equals("view") && !viewall.equals("View")
              && !viewall.equals("filter") && !viewall.equals("Filter")) {
            System.out.println("Please enter 'view all' or 'filter'");
            System.out.println("View all games or search by filter?");
            System.out.println("Enter 'view all' or 'filter':");
            viewall = myObj.nextLine();
          }
          // views all games
          if(viewall.equals("View all") || viewall.equals("view all") || viewall.equals("view") || viewall.equals("View")) {
            String sql = "SELECT * FROM game";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            System.out.println("List of games:");
            while(rs.next()) {
              String a = rs.getString(1);
              String b = rs.getString(2);
              String c = rs.getString(3);
              boolean d = rs.getBoolean(4);
              String e = rs.getString(5);
              String f = rs.getString(6);
              System.out.println("ID: " + a + ", " + "Title: " + b + ", " + "Rating: " 
                  + c + ", " + "Competitive?: " + d + ", " + "Genre: " + e + ", " + "Developer: " + f);
            } 
          }
          // searches games by filter
          else if(viewall.equals("Filter") || viewall.equals("filter")) {
            String filter;
            System.out.println("Search by: genre, developer, title, or rating?");
            System.out.println("Filter:");
            filter = myObj.nextLine();
            // searches games by genre
            while(!filter.equals("genre") && !filter.equals("developer") && !filter.equals("title") && 
                !filter.equals("rating")) {
              System.out.println("ERROR: Please enter valid filter");
              System.out.println("Filter: ");
              filter = myObj.nextLine();
            }
            // searching by genre
            if(filter.equals("genre")) {
              String sql = "SELECT genre_name FROM genre";
              PreparedStatement ps = conn.prepareStatement(sql);
              ResultSet rs = ps.executeQuery();
              System.out.println("Available genres: ");
              while(rs.next()) {
                String a = rs.getString(1);
                System.out.println(a);
              }
              System.out.println("Enter genre:");
              String genre;
              genre = myObj.nextLine();
              while(true) {
                CallableStatement function = conn.prepareCall("{? = CALL check_valid_genre(?)}");
                function.registerOutParameter(1, Types.BOOLEAN);
                function.setString(2, genre);
                ResultSet rs2 = function.executeQuery();
                rs2.next();
                if(!rs2.getBoolean(1)) {
                  System.out.println("Please enter valid genre");
                  System.out.println("Which genre?");
                  System.out.println("Enter genre:");
                  genre = myObj.nextLine();
                  continue;
                }
                else if(rs2.getBoolean(1)) {
                  break;
                }
              }
              CallableStatement cs3 = conn.prepareCall("{CALL view_games_genre(?)}");
              cs3.setString(1, genre);
              ResultSet rs3 = cs3.executeQuery();
              System.out.println("List of games:");
              while(rs3.next()) {
                String a = rs3.getString(1);
                String b = rs3.getString(2);
                String c = rs3.getString(3);
                boolean d = rs3.getBoolean(4);
                String e = rs3.getString(5);
                String f = rs3.getString(6);
                System.out.println("ID: " + a + ", " + "Title: " + b + ", " + "Rating: " 
                    + c + ", " + "Competitive?: " + d + ", " + "Genre: " + e + ", " + "Developer: " + f);
              }
              cs3.close();
            }
            // searching by developer
            else if (filter.equals("developer")) {
              String sql = "SELECT dev_name FROM developer";
              PreparedStatement ps = conn.prepareStatement(sql);
              ResultSet rs = ps.executeQuery();
              System.out.println("Available developers: ");
              while(rs.next()) {
                String a = rs.getString(1);
                System.out.println(a);
              }
              System.out.println("Enter developer:");
              String developer;
              developer = myObj.nextLine();
              while(true) {
                CallableStatement function = conn.prepareCall("{? = CALL check_valid_dev(?)}");
                function.registerOutParameter(1, Types.BOOLEAN);
                function.setString(2, developer);
                ResultSet rs2 = function.executeQuery();
                rs2.next();
                if(!rs2.getBoolean(1)) {
                  System.out.println("Please enter valid developer");
                  System.out.println("Which developer?");
                  System.out.println("Enter developer:");
                  developer = myObj.nextLine();
                  continue;
                }
                else if(rs2.getBoolean(1)) {
                  break;
                }
              }
              CallableStatement cs4 = conn.prepareCall("{CALL view_games_dev(?)}");
              cs4.setString(1, developer);
              ResultSet rs4 = cs4.executeQuery();
              System.out.println("List of games:");
              while(rs4.next()) {
                String a = rs4.getString("game_id");
                String b = rs4.getString("game_name");
                String c = rs4.getString("game_rating");
                boolean d = rs4.getBoolean("competitive");
                String e = rs4.getString("genre_name");
                String f = rs4.getString("dev_name");
                System.out.println("ID: " + a + ", " + "Title: " + b + ", " + "Rating: " 
                    + c + ", " + "Competitive?: " + d + ", " + "Genre: " + e + ", " + "Developer: " + f);
              }
              cs4.close();
            }
            // searching by title
            else if (filter.equals("title")) {
              System.out.println("Enter title:");
              String title;
              title = myObj.nextLine();
              while(true) {
                CallableStatement function = conn.prepareCall("{? = CALL check_valid(?)}");
                function.registerOutParameter(1, Types.BOOLEAN);
                function.setString(2, title);
                ResultSet rs = function.executeQuery();
                rs.next();
                if(!rs.getBoolean(1)) {
                  System.out.println("Please enter valid game title");
                  System.out.println("Enter title:");
                  title = myObj.nextLine();
                  continue;
                }
                else if(rs.getBoolean(1)) {
                  break;
                }
              }
              CallableStatement cs5 = conn.prepareCall("{CALL search_title(?)}");
              cs5.setString(1, title);
              ResultSet rs5 = cs5.executeQuery();
              System.out.println("List of games:");
              while(rs5.next()) {
                String a = rs5.getString(1);
                String b = rs5.getString(2);
                String c = rs5.getString(3);
                boolean d = rs5.getBoolean(4);
                String e = rs5.getString(5);
                String f = rs5.getString(6);
                System.out.println("ID: " + a + ", " + "Title: " + b + ", " + "Rating: " 
                    + c + ", " + "Competitive?: " + d + ", " + "Genre: " + e + ", " + "Developer: " + f);
              }
              cs5.close();
            }
            // searching by rating
            else if(filter.equals("rating")) {
              String sql2 = ("SELECT * FROM game ORDER BY game_rating DESC;");
              PreparedStatement pstmt2 = conn.prepareStatement(sql2);
              ResultSet rs2 = pstmt2.executeQuery();
              System.out.println("List of games:");
              while(rs2.next()) {
                String a = rs2.getString(1);
                String b = rs2.getString(2);
                String c = rs2.getString(3);
                boolean d = rs2.getBoolean(4);
                String e = rs2.getString(5);
                String f = rs2.getString(6);
                System.out.println("ID: " + a + ", " + "Title: " + b + ", " + "Rating: " 
                    + c + ", " + "Competitive?: " + d + ", " + "Genre: " + e + ", " + "Developer: " + f);
              }
            }
            else {
              System.out.println("ERROR Invalid input");
            }
          }

          // game selection
          System.out.println("Select a game? (Yes or No)");
          String response5;
          response5 = myObj.nextLine();
          while(!response5.equals("Yes") && !response5.equals("yes") && !response5.equals("No") &&
              !response5.equals("no")) {
            System.out.println("Please enter yes or no");
            System.out.println("Select a game? (Yes or No)");
            response5 = myObj.nextLine();
          }
          // choosing specific game
          if(response5.equals("Yes") || response5.equals("yes")) {
            System.out.println("Which game?");
            String response3;
            response3 = myObj.nextLine();
            while(true) {
              CallableStatement function = conn.prepareCall("{? = CALL check_valid(?)}");
              function.registerOutParameter(1, Types.BOOLEAN);
              function.setString(2, response3);
              ResultSet rs = function.executeQuery();
              rs.next();
              if(!rs.getBoolean(1)) {
                System.out.println("Please enter valid game");
                System.out.println("Which game?");
                response3 = myObj.nextLine();
                continue;
              }
              else if(rs.getBoolean(1)) {
                break;
              }
            }
            // adding to a user list
            System.out.println(response3);
            System.out.println("Add to favorites list or watch list? (Yes or No)");
            String response2;
            response2 = myObj.nextLine();
            while(!response2.equals("Yes") && !response2.equals("yes") && !response2.equals("No") &&
                !response2.equals("no")) {
              System.out.println("Please enter yes or no");
              System.out.println("Add to favorites list or watch list? (Yes or No)");
              response2 = myObj.nextLine();
            }

            if(response2.equals("Yes") || response2.equals("yes")) {
              String list;
              System.out.println("Which list?");
              list = myObj.nextLine();
              while(!list.equals("Favorites list") && !list.equals("favorites list") && !list.equals("Watch list") &&
                  !list.equals("watch list") && !list.equals("favorites") && !list.equals("Favorites") && !list.equals("watch")
                  && !list.equals("Watch")) {
                System.out.println("Please enter favorites list or watch list");
                System.out.println("Which list?");
                list = myObj.nextLine();
              }
              // adding to favorites list
              if(list.equals("favorites list") || list.equals("Favorites list") || list.equals("favorites")
                  || list.equals("Favorites")) {
                CallableStatement cs6 = conn.prepareCall("{? = CALL game_name_to_id(?)}");
                cs6.registerOutParameter(1, Types.INTEGER);
                cs6.setString(2, response3);
                ResultSet rs6 = cs6.executeQuery();
                CallableStatement cs7 = conn.prepareCall("{CALL add_to_favorites(?, ?)}");
                rs6.next();
                cs7.setInt(1, rs6.getInt(1));
                cs7.setString(2, sql_username2);
                cs7.executeQuery();
                System.out.println("Successfully added " + response3 + " to your favorites list");
                cs7.close();
                continue;
              }
              // adding to watch list
              else if(list.equals("watch list") || list.equals("Watch list")
                  || list.equals("watch") || list.equals("Watch")) {
                CallableStatement cs6 = conn.prepareCall("{? = CALL game_name_to_id(?)}");
                cs6.registerOutParameter(1, Types.INTEGER);
                cs6.setString(2, response3);
                ResultSet rs6 = cs6.executeQuery();
                CallableStatement cs7 = conn.prepareCall("{CALL add_to_watch(?, ?)}");
                rs6.next();
                cs7.setInt(1, rs6.getInt(1));
                cs7.setString(2, sql_username2);
                cs7.executeQuery();
                System.out.println("Successfully added " + response3 + " to your watch list");
                cs7.close();
                continue;
              }
            }
            else if(response2.equals("No") || response2.equals("no")) {                

            }
            // tournament registration
            String register;
            System.out.println("Would you like to register for a " + response3 + " tournament?");
            register = myObj.nextLine();
            while(!register.equals("Yes") && !register.equals("yes") && register.equals("No") && register.equals("no")) {
              System.out.println("Please enter yes or no");
              System.out.println("Would you like to register for a " + response3 + " tournament?");
              register = myObj.nextLine();
            }
            if(register.equals("Yes") || register.equals("yes")) {
              CallableStatement cs1 = conn.prepareCall("{? = CALL tourney_id(?)}");
              cs1.registerOutParameter(1, Types.INTEGER);
              String tourney;
              String sql = "SELECT game_id FROM game WHERE game.game_name = ?";
              PreparedStatement ps = conn.prepareStatement(sql);
              ps.setString(1, response3);
              ResultSet rs2 = ps.executeQuery();
              rs2.next();
              String sql2 = "SELECT tournament_name FROM tournament WHERE tournament.game_id = ?";
              PreparedStatement ps2 = conn.prepareStatement(sql2);
              ps2.setInt(1, rs2.getInt(1));
              ResultSet rs3 = ps2.executeQuery();
              while(rs3.next()) {
                String a = rs3.getString(1);
                System.out.println("Available tournaments for " + response3 + ": " + a);
              }
              System.out.println("Which tourney?");
              tourney = myObj.nextLine();
              cs1.setString(2, tourney);
              ResultSet rs = cs1.executeQuery();
              rs.next();
              CallableStatement cs = conn.prepareCall("{CALL register(?, ?)}");
              cs.setInt(1, rs.getInt(1));
              System.out.println("Enter full name:");
              String fullname;
              fullname = myObj.nextLine();
              cs.setString(2, fullname);
              cs.execute();
              System.out.println("Successfully registered for " + tourney + " tournament");
              cs.close();
            }
            else if(register.equals("No") || register.equals("No")) {
            }
          }
          else if(response5.equals("No") || response5.equals("no")) {
          }
        }

        // view favorites list
        else if(next.equals("Favorites list") || next.equals("favorites list")
            || next.equals("favorites") || next.equals("Favorites")) {
          String viewfaves = "SELECT games_list_id, game_id, game_name, game_rating, competitive, genre_name, dev_name "
              + "FROM favorites_list NATURAL JOIN game WHERE username=?";
          PreparedStatement ps1 = conn.prepareStatement(viewfaves);
          ps1.setString(1, sql_username2);
          ResultSet rs = ps1.executeQuery();
          while(rs.next()) {
            String a = rs.getString(1);
            String b = rs.getString(2);
            String c = rs.getString(3);
            String d = rs.getString(4);
            String e = rs.getString(5);
            String f = rs.getString(6);
            String g = rs.getString(7);
            System.out.println("List ID: " + a + ", Game ID: " + b + ", Name: " + c + ", Rating: " + d + ", Competitive?: "
                + e + ", Genre: " + f + ", Developer: " + g);
          }
          // asks if you want to make your favorites list private
          System.out.println("Would you like to make this list private? (Yes or No)");
          String priv;
          priv = myObj.nextLine();
          while(!priv.equals("Yes") && !priv.equals("yes") && !priv.equals("No") && !priv.equals("no")) {
            System.out.println("Please enter yes or no");
            System.out.println("Would you like to make this list private? (Yes or No)");
            priv = myObj.nextLine();
          }
          // sets favorites list to private
          if(priv.equals("Yes") || priv.equals("yes")) {
            CallableStatement cs = conn.prepareCall("{CALL private_favorites_list(?)}");
            cs.setString(1, sql_username2);
            cs.execute();
            System.out.println("Favorites list set to private");
            cs.close();
          }
          else if(priv.equals("No") || priv.equals("no")) {
          }

          // deleting game from favorites list
          System.out.println("Would you like to delete a game from your favorites list? (Yes or No)");
          String delete;
          delete = myObj.nextLine();
          while(!delete.equals("Yes") && !delete.equals("yes") && !delete.equals("No") &&
              !delete.equals("no")) {
            System.out.println("Please enter yes or no");
            System.out.println("Would you like to delete a game from your favorites list? (Yes or No)");
            delete = myObj.nextLine();
          }

          if(delete.equals("Yes") || delete.equals("yes")) {
            System.out.println("Which game?");
            String game;
            game = myObj.nextLine();
            CallableStatement cs = conn.prepareCall("{CALL delete_from_faves(?,?)}");
            cs.setString(1, game);
            cs.setString(2, sql_username2);
            cs.execute();
            cs.close();
            System.out.println("Successfully deleted " + game +
                " from your favorites list");
            continue;
          }
          else if(delete.equals("No") || delete.equals("no")) {
            continue;
          }
        }
        // viewing watch list
        else if(next.equals("Watch list") || next.equals("watch list")
            || next.equals("Watch") || next.equals("watch")) {
          String viewwatch = "SELECT games_list_id, game_id, game_name, game_rating, competitive, genre_name, dev_name "
              + "FROM watch_list NATURAL JOIN game WHERE username=?";
          PreparedStatement ps1 = conn.prepareStatement(viewwatch);
          ps1.setString(1, sql_username2);
          ResultSet rs = ps1.executeQuery();
          while(rs.next()) {
            String a = rs.getString(1);
            String b = rs.getString(2);
            String c = rs.getString(3);
            String d = rs.getString(4);
            String e = rs.getString(5);
            String f = rs.getString(6);
            String g = rs.getString(7);
            System.out.println("List ID: " + a + ", Game ID: " + b + ", Name: " + c + ", Rating: " + d + ", Competitive?: "
                + e + ", Genre: " + f + ", Developer: " + g);
          }
          // asks if you want to make your watch list private
          System.out.println("Would you like to make this list private? (Yes or No)");
          String priv;
          priv = myObj.nextLine();
          while(!priv.equals("Yes") && !priv.equals("yes") && !priv.equals("No") && !priv.equals("no")) {
            System.out.println("Please enter yes or no");
            System.out.println("Would you like to make this list private? (Yes or No)");
            priv = myObj.nextLine();
          }
          if(priv.equals("Yes") || priv.equals("yes")) {
            CallableStatement cs = conn.prepareCall("{CALL private_watch_list(?)}");
            cs.setString(1, sql_username2);
            cs.execute();
            System.out.println("Watch list set to private");
            cs.close();
          }
          else if(priv.equals("No") || priv.equals("no")) {
          }
          // deleting game from watch list
          System.out.println("Would you like to delete a game from your watch list? (Yes or No)");
          String delete;
          delete = myObj.nextLine();
          while(!delete.equals("Yes") && !delete.equals("yes") && !delete.equals("No") && !delete.equals("no")) {
            System.out.println("Please enter yes or no");
            System.out.println("Would you like to delete a game from your watch list? (Yes or No)");
            delete = myObj.nextLine();
          }
          if(delete.equals("Yes") || delete.equals("yes")) {
            System.out.println("Which game?");
            String game;
            game = myObj.nextLine();
            CallableStatement cs = conn.prepareCall("{CALL delete_from_watch(?,?)}");
            cs.setString(1, game);
            cs.setString(2, sql_username2);
            cs.execute();
            cs.close();
            System.out.println("Successfully deleted " + game +
                " from your watch list");
          }
          else if(delete.equals("No") || delete.equals("no")) {
          }
        }
        // view recommendations list
        else if(next.equals("Recommendations list") || next.equals("recommmendations list")
            || next.equals("Recommendations") || next.equals("recommendations")) {
          String viewfaves = "SELECT games_list_id, game_id, game_name, game_rating, competitive, genre_name, dev_name "
              + "FROM recommendations_list NATURAL JOIN game WHERE username=?";
          PreparedStatement ps1 = conn.prepareStatement(viewfaves);
          ps1.setString(1, sql_username2);
          ResultSet rs = ps1.executeQuery();
          while(rs.next()) {
            String a = rs.getString(1);
            String b = rs.getString(2);
            String c = rs.getString(3);
            String d = rs.getString(4);
            String e = rs.getString(5);
            String f = rs.getString(6);
            String g = rs.getString(7);
            System.out.println("List ID: " + a + ", Game ID: " + b + ", Name: " + c + ", Rating: " + d + ", Competitive?: "
                + e + ", Genre: " + f + ", Developer: " + g);
          }
          // asks if you want to make your recommendations list private
          System.out.println("Would you like to make this list private? (Yes or No)");
          String priv;
          priv = myObj.nextLine();
          while(!priv.equals("Yes") && !priv.equals("yes") && !priv.equals("No") && !priv.equals("no")) {
            System.out.println("Please enter yes or no");
            System.out.println("Would you like to make this list private? (Yes or No)");
            priv = myObj.nextLine();
          }
          // sets rec list to private
          if(priv.equals("Yes") || priv.equals("yes")) {
            CallableStatement cs = conn.prepareCall("{CALL private_favorites_list(?)}");
            cs.setString(1, sql_username2);
            cs.execute();
            System.out.println("Favorites list set to private");
            cs.close();
          }
          else if(priv.equals("No") || priv.equals("no")) {
          }
        }
        // logging out
        else if(next.equals("Logout") || next.equals("logout")) {
          System.out.println("Successfully logged out");
          conn.close();
          System.exit(0);
          break;
        }
        // viewing user trends
        else if(next.equals("User trends") || next.equals("user trends")) {
          System.out.println("Which user trend would you like to view?");
          String popular;
          // asks if you want to view user trend about competitive vs casual games
          System.out.println("Preferred competitive status?");
          popular = myObj.nextLine();
          while(!popular.equals("Yes") && !popular.equals("yes") && !popular.equals("No") && !popular.equals("no")) {
            System.out.println("Please enter yes or no");
            System.out.println("Preferred competitive status?");
            popular = myObj.nextLine();
          }
          if(popular.equals("Yes") || popular.equals("yes")) {
            CallableStatement cs = conn.prepareCall("{? = CALL prefer_competitive_or_casual()}");
            cs.registerOutParameter(1, Types.VARCHAR);
            ResultSet rs = cs.executeQuery();
            while(rs.next()) {
              String a = rs.getString(1);
              System.out.println(a);
            }
          }
          else if(popular.equals("No") || popular.equals("no")) {                  
          }
          // asks if you want to view user trend about the most popular genre
          String popgenre;
          System.out.println("Most popular genre?");
          popgenre = myObj.nextLine();
          while(!popgenre.equals("Yes") && !popgenre.equals("yes") && !popgenre.equals("No") && !popgenre.equals("no")) {
            System.out.println("Please enter yes or no");
            System.out.println("Most popular genre?");
            popgenre = myObj.nextLine();
          }
          if(popgenre.equals("Yes") || popgenre.equals("yes")) {
            CallableStatement cs = conn.prepareCall("{CALL most_popular_genre()}");
            ResultSet rs = cs.executeQuery();
            while(rs.next()) {
              String a = rs.getString(1);
              System.out.println(a);
            }
          }
          else if(popgenre.equals("No") || popgenre.equals("no")) {                
          }
          // asks if you want to view user trend about the most popular game
          String popgame;
          System.out.println("Most popular game?");
          popgame = myObj.nextLine();
          while(!popgame.equals("Yes") && !popgame.equals("yes") && !popgame.equals("No") && !popgame.equals("no")) {
            System.out.println("Please enter yes or no");
            System.out.println("Most popular game?");
            popgame = myObj.nextLine();
          }
          if(popgame.equals("Yes") || popgame.equals("yes")) {
            CallableStatement cs = conn.prepareCall("{CALL most_popular_game()}");
            ResultSet rs = cs.executeQuery();
            while(rs.next()) {
              String a = rs.getString(1);
              System.out.println(a);
            }
          }
          else if(popgame.equals("No") || popgame.equals("no")) {
          }
        }
        // personalized recommendations list based on your favorites and watch list
        String recommendation;
        System.out.println("Would you like a personalized recommendation list? (Yes or No)");
        recommendation = myObj.nextLine();
        while(!recommendation.equals("Yes") && !recommendation.equals("yes") && 
            !recommendation.equals("No") && !recommendation.equals("no") ) {
          System.out.println("Please enter yes or no");
          System.out.println("Would you like a personalized recommendation list? (Yes or No)");
          recommendation = myObj.nextLine();
        }
        if(recommendation.equals("Yes") || recommendation.equals("yes")) {
          String genre;
          System.out.println("What is your favorite genre?");
          genre = myObj.nextLine();
          CallableStatement csta = conn.prepareCall("{CALL add_to_recommendations(?, ?)}");
          csta.setString(1, genre);
          csta.setString(2, sql_username2);
          csta.execute();
          System.out.println("Recommendations list successfully created");
          System.out.println("Would you like to view your recommendations list? (Yes or No)");
          String view;
          view = myObj.nextLine();
          if(view.equals("Yes") || view.equals("yes")) {
            String viewrecs = "SELECT games_list_id, game_id, game_name, game_rating, competitive, genre_name, dev_name "
                + "FROM recommendations_list NATURAL JOIN game WHERE username=?";
            PreparedStatement ps = conn.prepareStatement(viewrecs);
            ps.setString(1, sql_username2);
            ResultSet rss = ps.executeQuery();
            while(rss.next()) {
              String a = rss.getString(1);
              String b = rss.getString(2);
              String c = rss.getString(3);
              String d = rss.getString(4);
              String e = rss.getString(5);
              String f = rss.getString(6);
              String g = rss.getString(7);
              System.out.println("List ID: " + a + ", Game ID: " + b + ", Name: " + c + ", Rating: " + d + ", Competitive?: "
                  + e + ", Genre: " + f + ", Developer: " + g);
            }
          }
          else System.out.println("ERROR Invalid input");
        }
        else if(recommendation.equals("No") || recommendation.equals("no")) {
        }
        else System.out.println("ERROR: Invalid input");
      }
      // closes scanner object
      myObj.close();
    }
    // catches exception errors
    catch (SQLException ex) {
      System.out.println("ERROR: " + ex.getMessage());
    }
  }

  /**
   * Connect to the DB
   */
  public static void main(String[] args) throws SQLException {
    JavaMySql app = new JavaMySql();
    app.run();
  }
}






