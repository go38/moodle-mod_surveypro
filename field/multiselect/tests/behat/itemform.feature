@mod @mod_surveypro @surveyprofield @surveyprofield_multiselect
Feature: test the use of multiselect setup form
  In order to test multiselect setup form
  As a teacher
  I fill each its field and I return back to verify all is where I wrote it

  @javascript
  Scenario: use reserved elements
    Given the following "courses" exist:
      | fullname               | shortname              | category | groupmode |
      | Multiselect setup form | Multiselect setup form | 0        | 0         |
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@nowhere.net |
    And the following "course enrolments" exist:
      | user     | course                 | role           |
      | teacher1 | Multiselect setup form | editingteacher |
    And the following "activities" exist:
      | activity  | name                        | intro                       | course                 | idnumber   |
      | surveypro | Test multiselect setup form | Test multiselect setup form | Multiselect setup form | surveypro1 |
    And surveypro "Test multiselect setup form" contains the following items:
      | type   | plugin  |
      | field  | boolean |
    And I log in as "teacher1"
    And I follow "Multiselect setup form"
    And I follow "Test multiselect setup form"
    And I follow "Layout"

    # add an multiselect item
    And I set the field "typeplugin" to "Multiple selection"
    And I press "Add"

    And I expand all fieldsets
    And I set the following fields to these values:
      | Content                  | What do you usually get for breakfast? |
      | Required                 | 1                                      |
      | Indent                   | 1                                      |
      | Question position        | left                                   |
      | Element number           | II.a                                   |
      | Hide filling instruction | 1                                      |
      | Variable                 | A1                                     |
      | Additional note          | Additional note                        |
      | Hidden                   | 1                                      |
      | Search form              | 1                                      |
      | Reserved                 | 1                                      |
      | Parent element           | Boolean [1]: Is this true?             |
      | Parent content           | 1                                      |
    And I set the field "Options" to multiline:
      """
      milk


      coffee
           butter

      bread


      """
    And I set the field "Options" to multiline:
      """


      coffee
          bread


      """
    And I set the following fields to these values:
      | Height in rows           | 4                                       |
      | Download format          | value of selected items                 |
      | Minimum required items   | 5                                       |
    And I press "Add"

    Then I should see "The minimum number of items to select must be lower than 4 (options count)"
    And I set the following fields to these values:
      | Minimum required items   | 3                                       |
    And I press "Add"

    And I follow "edit_item_2"
    Then the field "Content" matches value "What do you usually get for breakfast?"
    Then the field "Required" matches value "1"
    Then the field "Indent" matches value "1"
    Then the field "Question position" matches value "left"
    Then the field "Element number" matches value "II.a"
    Then the field "Hide filling instruction" matches value "1"
    Then the field "Variable" matches value "A1"
    Then the field "Additional note" matches value "Additional note"
    Then the field "Hidden" matches value "1"
    Then the field "Search form" matches value "1"
    Then the field "Reserved" matches value "1"
    Then the field "Parent element" matches value "Boolean [1]: Is this true?"
    Then the field "Parent content" matches value "1"
    Then the field "Options" matches multiline:
      """
      milk
      coffee
      butter
      bread
      """
    Then the field "Default" matches multiline:
      """
      coffee
      bread
      """
    Then the field "Height in rows" matches value "4"
    Then the field "Download format" matches value "value of selected items"
    Then the field "Minimum required items" matches value "3"
    And I press "Cancel"

    And I follow "show_item_2"
    And I follow "layout_preview"
    Then I should see "II.a: What do you usually get for breakfast?"
    Then the field "id_surveypro_field_multiselect_2" matches value "coffee, bread"
    Then I should see "Additional note"
