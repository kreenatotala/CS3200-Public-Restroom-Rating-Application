import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.Scanner;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * @author Kreena Totala
 */
class restrooms {

  /** The name of the computer running MySQL */
  private final String serverName = "localhost";

  /** The port of the MySQL server (default is 3306) */
  private final int portNumber = 3306;

  /** The name of the database we are testing with (this default is installed with MySQL) */
  private final String dbName = "pr";

  /** The name of the table we are testing with */
  private final String tableName = "JDBC_TEST";
  private final boolean useSSL = false;

  /**
   * Get a new database connection
   *
   * @return
   * @throws SQLException
   */
  public Connection getConnection(String user, String pass) throws SQLException {
    Connection conn = null;
    Properties connectionProps = new Properties();
    connectionProps.put("user", user);
    connectionProps.put("password", pass);

    conn = DriverManager.getConnection("jdbc:mysql://"
            + this.serverName + ":" + this.portNumber + "/" + this.dbName + "?characterEncoding=UTF-8&useSSL=false",
        connectionProps);

    return conn;
  }

  /**
   * Run a SQL command which does not return a recordset:
   * CREATE/INSERT/UPDATE/DELETE/DROP/etc.
   *
   * @throws SQLException If something goes wrong
   */
  public void executeUpdate(Connection conn, String command) throws SQLException {
    Statement stmt = null;
    try {
      stmt = conn.createStatement();
      stmt.executeUpdate(command); // This will throw a SQLException if it fails
    } finally {

      // This will run whether we throw an exception or not
      if (stmt != null) { stmt.close(); }
    }
  }

  /**
   * Connect to MySQL and do some stuff.
   */
  public void run(String user, String pass) {

    // Connect to MySQL
    Connection conn = null;
    try {
      conn = this.getConnection(user, pass);
      System.out.println("Connected to database");
    } catch (SQLException e) {
      System.out.println("ERROR: Could not connect to the database");
      e.printStackTrace();
      return;
    }

    // Create a table
    try {
      String createString =
          "CREATE TABLE " + this.tableName + " ( " +
              "ID INTEGER NOT NULL, " +
              "NAME varchar(40) NOT NULL, " +
              "STREET varchar(40) NOT NULL, " +
              "CITY varchar(20) NOT NULL, " +
              "STATE char(2) NOT NULL, " +
              "ZIP char(5), " +
              "PRIMARY KEY (ID))";
      this.executeUpdate(conn, createString);
      System.out.println("Created a table");
    } catch (SQLException e) {
      System.out.println("ERROR: Could not create the table");
      e.printStackTrace();
      return;
    }

    // Drop the table
    try {
      String dropString = "DROP TABLE " + this.tableName;
      this.executeUpdate(conn, dropString);
      System.out.println("Dropped the table");
    } catch (SQLException e) {
      System.out.println("ERROR: Could not drop the table");
      e.printStackTrace();
      return;
    }
  }

  /**
   * MENUS
   * @param conn
   */

  // main menu
  public void mainMenu(Connection conn) throws SQLException {
    Scanner sc = new Scanner(System.in);
    System.out.println("Welcome to the Public Restroom Finder Application");
    System.out.println("Select Option by Entering Number: ");
    System.out.println("1: View Database");
    System.out.println("2: Login");
    System.out.println("3: Sign up");
    int choice = 0;
    while(choice!=1 && choice!=2 && choice !=3) {
      if (sc.hasNext()) {
        choice = sc.nextInt();
      }

      if (choice != 1 && choice != 2 && choice !=3) {
        System.out.println("Invalid number option, please try again");
        choice = sc.nextInt();
      }
    }

    switch (choice) {
      case 1:
        viewDB(conn);
        break;
      case 2:
        logIn(conn);
        break;
      case 3:
        signUp(conn);
        break;
    }

  }

  // member view of DB app
  public void memberMenu(Connection conn) throws SQLException {
    System.out.println();
    System.out.println("Welcome Member!");
    System.out.println();
    Scanner sc = new Scanner(System.in);
    System.out.println("Select Operation by Entering Number: ");
    System.out.println("1: Create Options");
    System.out.println("2: Read Options");
    System.out.println("3: Update Options");
    System.out.println("4: Delete Options");

    int choice = sc.nextInt();

    switch (choice) {
      case 1:
        createOptions(conn);
        break;
      case 2:
        readOptions(conn);
        break;
      case 3:
        updateOptions(conn);
        break;
      case 4:
        deleteOptions(conn);
        break;
    }

    if(choice != 1 && choice != 2 && choice != 3 && choice != 4) {
      System.out.println("Please enter one of the number corresponding to the menus above");
      choice = sc.nextInt();
      sc.close();
    }
  }

  /**
   * OPERATIONS
   */

  public void createOptions(Connection conn) throws SQLException {
    Scanner sc = new Scanner(System.in);
    System.out.println("CREATE OPERATIONS");
    System.out.println("Select operation by entering a number: ");
    System.out.println("1: Add restroom review");
    System.out.println("2: Add restroom to favorites");

    int choice = sc.nextInt();

    switch (choice) {
      case 1:
        addReview(conn);
        break;
      case 2:
        addFavorite(conn);
        break;
    }
  }

  public void readOptions(Connection conn) throws SQLException {
    Scanner sc = new Scanner(System.in);
    System.out.println("READ OPERATIONS");
    System.out.println("Select operation by entering a number: ");
    System.out.println("1: View restroom reviews");

    int choice = sc.nextInt();

    switch (choice) {
      case 1:
        viewDB(conn);
        break;
    }
  }

  public void updateOptions(Connection conn) throws SQLException {
    Scanner sc = new Scanner(System.in);
    System.out.println("UPDATE OPERATIONS");
    System.out.println("Select operation by entering a number: ");
    System.out.println("1: Update Restroom Review");
    System.out.println("2: Update Favorites List");

    int choice = sc.nextInt();

    switch (choice) {
      case 1:
        updateReview(conn);
        break;
    }
  }

  public void deleteOptions(Connection conn) throws SQLException {
    Scanner sc = new Scanner(System.in);
    System.out.println("DELETE OPERATIONS");
    System.out.println("Select operation by entering a number: ");
    System.out.println("1: Delete a review");
    System.out.println("2: Delete a favorite");
    int choice = sc.nextInt();

    switch (choice) {
      case 1:
        deleteReview(conn);
        break;
      case 2:
        deleteFavorite(conn);
        break;
    }
  }

  /**
   * CREATE OPERATIONS
   */

  public void addReview(Connection conn) throws SQLException {
    Scanner sc = new Scanner(System.in);
    System.out.println("Enter a restroom name: ");
    String name = sc.nextLine().toLowerCase();
    System.out.println("Enter a gender (male, female, family): ");
    String gender = sc.nextLine().toLowerCase();
    System.out.println("Enter the region of Boston it is located in: ");
    String region = sc.nextLine();
    System.out.println("Enter any comments/reviews: ");
    String review = sc.nextLine();
    System.out.println("Enter a rating: ");
    int rating = sc.nextInt();

    String sql = "CALL addRestroom(?, ?, ?, ?, ?)";
    try {
      CallableStatement stmt = conn.prepareCall(sql);
      stmt.setString(1, name);
      stmt.setString(2, gender);
      stmt.setString(3, region);
      stmt.setString(4,  review);
      stmt.setInt(5, rating);

      stmt.executeUpdate();
      System.out.println("1 review added");
    }
    catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    memberMenu(conn);
  }

  public void addFavorite(Connection conn) {
    System.out.println("Sorry, this function isn't available yet!");
  }

  /**
   * READ OPERATIONS
   */
  public void viewDB(Connection conn) throws SQLException {

    // retrieves a result set of all the region names
    PreparedStatement ps = conn.prepareStatement(
        "SELECT regionName FROM region");
    ResultSet rs = ps.executeQuery();

    // makes a list of region names
    ArrayList<String> regionNames = new ArrayList<>();
    while (rs.next()) {
      regionNames.add(rs.getString("regionName"));
    }

    // asks user for a region name
    Scanner sc = new Scanner(System.in);
    System.out.println("Enter a region of Boston that you would like to locate restrooms in: ");
    String region = sc.nextLine();

    // checks if the character name entered is valid (re-prompts if not valid)
    boolean flag = true;
    while (flag) {
      flag = false;
      try {
        if (!regionNames.contains(region)) {
          throw new IllegalArgumentException();
        }
      } catch (IllegalArgumentException e) {
        flag = true;
        System.out.println("Please enter a valid region name.");
        region = sc.nextLine();
      }
    }

    // call searchRegion
    CallableStatement cs = conn.prepareCall("call searchRegion(?)");
    cs.setString(1, region);
    ResultSet rs1 = cs.executeQuery();

    // print result set
    while (rs1.next()) {
      String restroom_name = rs1.getString("rrName");
      String gender = rs1.getString("gender");
      String regionName = rs1.getString("region");
      String rating = rs1.getString("rating");
      String review = rs1.getString("review");

      System.out.println(
          "Name: " + restroom_name + "\n"
              + "Gender: " + gender + "\n"
              + "Region: " + regionName + "\n"
              + "Rating: " + rating + "\n"
          + "Review: " + review + "\n"
      );
    }

    // disconnects from DB
    try { rs.close(); } catch (Exception e) { /* Ignored */ }
    try { ps.close(); } catch (Exception e) { /* Ignored */ }
    try { cs.close(); } catch (Exception e) { /* Ignored */ }

  }

  /**
   * UPDATE OPERATIONS
   */

  public void updateReview(Connection conn) throws SQLException {
    Scanner sc = new Scanner(System.in);
    System.out.println("UPDATE OPERATIONS");
    System.out.println("Select operation by entering a number: ");
    System.out.println("1: Update Restroom Name");
    System.out.println("2: Update Restroom Gender");
    System.out.println("3: Update Restroom Region");
    System.out.println("4: Update Restroom Rating");
    System.out.println("5: Update Restroom Review");
    int choice = sc.nextInt();
    System.out.println("Enter the number of the restroom you wish to edit");
    int entryNum = sc.nextInt();

    switch (choice) {
      case 1:
        System.out.println("Enter the new name you wish to change it to");
        String newName = sc.next();
        String sql = "CALL updateRestroomName(?, ?)";

        try {
          CallableStatement stmt = conn.prepareCall(sql);
          stmt.setInt(1, entryNum);
          stmt.setString(2, newName);
          int rowsUpdated = stmt.executeUpdate();
          if (rowsUpdated > 0) {
            System.out.println("An existing restroom's name was updated successfully!");
          }
        }
        catch (SQLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }

        memberMenu(conn);
        break;
      case 2:
        System.out.println("Enter the new gender you wish to change it to");
        String newGender = sc.next();
        String sql1 = "CALL updateRestroomGender(?, ?)";

        try {
          CallableStatement stmt = conn.prepareCall(sql1);
          stmt.setInt(1, entryNum);
          stmt.setString(2, newGender);
          int rowsUpdated = stmt.executeUpdate();
          if (rowsUpdated > 0) {
            System.out.println("An existing restroom's gender was updated successfully!");
          }
        }
        catch (SQLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }

        memberMenu(conn);
        break;
      case 3:
        System.out.println("Enter the new region you wish to change it to");
        String newRegion = sc.next();
        String sql2 = "CALL updateRestroomRegion(?, ?)";

        try {
          CallableStatement stmt = conn.prepareCall(sql2);
          stmt.setInt(1, entryNum);
          stmt.setString(2, newRegion);
          int rowsUpdated = stmt.executeUpdate();
          if (rowsUpdated > 0) {
            System.out.println("An existing restroom's region was updated successfully!");
          }
        }
        catch (SQLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }

        memberMenu(conn);
        break;
      case 4:
        System.out.println("Enter the new rating you wish to change it to");
        String newRating = sc.next();
        String sql3 = "CALL updateRestroomRating(?, ?)";

        try {
          CallableStatement stmt = conn.prepareCall(sql3);
          stmt.setInt(1, entryNum);
          stmt.setString(2, newRating);
          int rowsUpdated = stmt.executeUpdate();
          if (rowsUpdated > 0) {
            System.out.println("An existing restroom's rating was updated successfully!");
          }
        }
        catch (SQLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }

        memberMenu(conn);
        break;
      case 5:
        System.out.println("Enter the new review you wish to change it to");
        String newReview = sc.next();
        String sql4 = "CALL updateRestroomGender(?, ?)";

        try {
          CallableStatement stmt = conn.prepareCall(sql4);
          stmt.setInt(1, entryNum);
          stmt.setString(2, newReview);
          int rowsUpdated = stmt.executeUpdate();
          if (rowsUpdated > 0) {
            System.out.println("An existing restroom's review was updated successfully!");
          }
        }
        catch (SQLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }

        memberMenu(conn);
        break;
    }

    // returns to the main menu
    memberMenu(conn);

  }

  /**
   * DELETE OPERATIONS
   */

  public void deleteReview(Connection conn) throws SQLException {
    String sql = "CALL deleteRestroom(?)";
    System.out.println("Enter the number of the restroom you wish to delete");
    Scanner sc = new Scanner(System.in);
    int entryNum = sc.nextInt();

    try {
      // deletes the kitten with the given kitten id
      CallableStatement stmt = conn.prepareCall(sql);
      stmt.setInt(1, entryNum);

      stmt.executeUpdate();
    }
    catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    // returns to the main menu
    memberMenu(conn);
  }

  public void deleteFavorite(Connection conn) {
    System.out.println("Sorry, this function isn't available yet!");
  }

  /**
   * LOGIN METHODS
   */

  // log in as a user
  public void logIn(Connection conn) throws SQLException {
    int choice = validLogIn(conn);

    switch (choice) {
      case -1:
        System.out.println("Invalid Login");
        mainMenu(conn);
      case 0:
        memberMenu(conn);
        break;
    }
  }

  // checks that a valid username and password is provided
  public int validLogIn(Connection conn) throws SQLException {
    Statement stmt = null;
    Statement stmt2 = null;
    ArrayList<String> usernames = new ArrayList<>();
    ArrayList<String> passwords = new ArrayList<>();

    try {
      stmt = conn.createStatement();
      String sql = "SELECT userName, password FROM user";
      ResultSet rs = stmt.executeQuery(sql);

      while (rs.next()) {
        String username = rs.getString("userName");
        String password = rs.getString("password");
        usernames.add(username);
        passwords.add(password);
      }
    }
    catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    Scanner sc = new Scanner(System.in);
    System.out.println("Enter DB Username: ");
    String user = sc.nextLine();

    int stopper = 0;
    while (stopper == 0) {
      if (usernames.contains(user)) {
        stopper = 1;
      }
      else {
        System.out.println("Sorry, this account does not exist, please try again or sign up for an account");
        user = sc.nextLine();
      }
    }

    System.out.println("Enter Password: ");
    String pass = sc.nextLine();

    int stopper2 = 0;
    while (stopper2 == 0) {
      if (passwords.contains(pass)) {
        stopper2 = 1;
      }
      else {
        System.out.println("Sorry, password isn't valid, please try again");
        pass = sc.nextLine();
      }
    }

    int checkUser = usernames.indexOf(user);
    int checkPass = passwords.indexOf(pass);
    if (checkUser == checkPass) {
      return 0;
    }
    else {
      System.out.println("Incorrect login, returning to home page...");
      mainMenu(conn);
      return -1;
    }
  }

  public void signUp(Connection conn) throws SQLException {
    Scanner sc = new Scanner(System.in);
    System.out.println("Enter a username");
    String username = sc.next();

    System.out.println("Enter a password");
    String password = sc.next();

    try {
      Statement stmt = conn.createStatement();
      String sql = "INSERT INTO user (userName, password) VALUES ('" + username + "', '" + password + "')";
      stmt.execute(sql);
      memberMenu(conn);
    } catch (SQLException e) {
      e.printStackTrace();
      System.out.println("Sign up unsuccessful, try again!");
      mainMenu(conn);
    }

  }

  /**
   * Connect to the DB and do some stuff
   */
  public static void main(String[] args) throws SQLException {
    restrooms app = new restrooms();
    String user = "";
    String pass = "";

    // asks user for username
    Scanner reader1 = new Scanner(System.in);  // Reading from System.in
    System.out.println("Enter your username: ");
    user = reader1.next();

    // asks user for password
    Scanner reader2 = new Scanner(System.in);  // Reading from System.in
    System.out.println("Enter your password: ");
    pass = reader2.next();

    app.mainMenu(app.getConnection(user, pass));

  }
}
