CLASS ltcl_aoc_day4_1 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:

      example_test FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_aoc_day4_1 IMPLEMENTATION.

  METHOD example_test.
    "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( |ecl:gry pid:860033327 eyr:2020 hcl:#fffffd| ).
    input->add( |byr:1937 iyr:2017 cid:147 hgt:183cm| ).
    input->add( || ).
    input->add( |iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884| ).
    input->add( |hcl:#cfa07d byr:1929| ).
    input->add( || ).
    input->add( |hcl:#ae17e1 iyr:2013| ).
    input->add( |eyr:2024| ).
    input->add( |ecl:brn pid:760753108 byr:1931| ).
    input->add( |hgt:179cm| ).
    input->add( || ).
    input->add( |hcl:#cfa07d eyr:2025 pid:166559648| ).
    input->add( |iyr:2011 ecl:brn hgt:59in| ).

    "When
    DATA(cut) = NEW zcl_aoc_2020_day4_1(  ).
    cut->set_input( input ).
    cut->run(  ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_result(  ) exp = 2 ).
  ENDMETHOD.


ENDCLASS.
