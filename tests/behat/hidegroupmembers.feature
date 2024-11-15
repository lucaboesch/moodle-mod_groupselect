@mod @mod_groupselect
Feature: Setting to enable hiding of group members students.
  In order to enrol in a group
  As a student
  I need to see other group members

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
      | student1 | Student   | 1        | student1@example.com |
      | student2 | Student   | 2        | student2@example.com |
      | student3 | Student   | 3        | student1@example.com |
      | student4 | Student   | 4        | student2@example.com |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | student1 | C1     | student        |
      | student2 | C1     | student        |
      | student3 | C1     | student        |
      | student4 | C1     | student        |
    And the following "groups" exist:
      | name    | course | idnumber |
      | Group 1 | C1     | G1       |
    And the following "group members" exist:
      | user     | group |
      | student1 | G1    |

  @javascript
  Scenario: Students see group members when choosing and hidegroupmembers is off.
    Given I log in as "admin"
    And I navigate to "Users > Permissions > Define roles" in site administration
    And I click on "Edit Student role" "link"
    And I fill the capabilities form with the following permissions:
      | moodle/course:viewparticipants | Allow |
    And I press "Save changes"
    And I am on site homepage
    And I follow "Course 1"
    And I turn editing mode on
    And I add a groupselect activity to course "Course 1" section "1" and I fill the form with:
      | Name        | Group self-selection       |
      | Hide group members for students | 0      |
    And I log out
    And I log in as "student2"
    And I am on "Course 1" course homepage
    And I follow "Group self-selection"
    And I should not see "Member list not available"
    Then I should see "Student 1"

  @javascript
  Scenario: Students do not see group members when choosing and hidegroupmembers is off but capability is off.
    Given I log in as "admin"
    And I navigate to "Users > Permissions > Define roles" in site administration
    And I click on "Edit Student role" "link"
    And I fill the capabilities form with the following permissions:
      | moodle/course:viewparticipants | Prevent |
    And I press "Save changes"
    And I am on site homepage
    And I follow "Course 1"
    And I turn editing mode on
    And I add a groupselect activity to course "Course 1" section "1" and I fill the form with:
      | Name        | Group self-selection       |
      | Hide group members for students | 0      |
    And I log out
    And I log in as "student2"
    And I am on "Course 1" course homepage
    And I follow "Group self-selection"
    And I should not see "Student 1"
    Then I should see "Member list not available"

  @javascript
  Scenario: Students do not see group members when choosing and hidegroupmembers is on.
    Given I log in as "admin"
    And I navigate to "Users > Permissions > Define roles" in site administration
    And I click on "Edit Student role" "link"
    And I fill the capabilities form with the following permissions:
      | moodle/course:viewparticipants | Allow |
    And I press "Save changes"
    And I am on site homepage
    And I follow "Course 1"
    And I turn editing mode on
    And I add a groupselect activity to course "Course 1" section "1" and I fill the form with:
      | Name        | Group self-selection       |
      | Hide group members for students | 1      |
    And I log out
    And I log in as "student2"
    And I am on "Course 1" course homepage
    And I follow "Group self-selection"
    And I should see "Student 2"
    And I should not see "Student 1"
    Then I should see "Member list not available"
