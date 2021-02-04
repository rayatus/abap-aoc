CLASS ltcl_aoc_day4_2 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      example_valid_test FOR TESTING RAISING cx_static_check,
      example_invalid_test FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_aoc_day4_2 IMPLEMENTATION.

  METHOD example_invalid_test.
    "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( |eyr:1972 cid:100| ).
    input->add( |hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926| ).
    input->add( || ).
    input->add( |iyr:2019| ).
    input->add( |hcl:#602927 eyr:1967 hgt:170cm| ).
    input->add( |ecl:grn pid:012533040 byr:1946| ).
    input->add( || ).
    input->add( |hcl:dab227 iyr:2012| ).
    input->add( |ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277| ).
    input->add( || ).
    input->add( |hgt:59cm ecl:zzz| ).
    input->add( |eyr:2038 hcl:74454a iyr:2023| ).
    input->add( |pid:3556412378 byr:2007| ).

    "When
    DATA(cut) = NEW zcl_aoc_2020_day4_2(  ).
    cut->set_input( input ).
    cut->run(  ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_result(  ) exp = 0 ).
  ENDMETHOD.

  METHOD example_valid_test.
    "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( |pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980| ).
    input->add( |hcl:#623a2f| ).
    input->add( || ).
    input->add( |eyr:2029 ecl:blu cid:129 byr:1989| ).
    input->add( |iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm| ).
    input->add( || ).
    input->add( |hcl:#888785| ).
    input->add( |hgt:164cm byr:2001 iyr:2015 cid:88| ).
    input->add( |pid:545766238 ecl:hzl| ).
    input->add( |eyr:2022| ).
    input->add( || ).
    input->add( |iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719| ).
    "When
    DATA(cut) = NEW zcl_aoc_2020_day4_2(  ).
    cut->set_input( input ).
    cut->run(  ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_result(  ) exp = 4 ).
  ENDMETHOD.

ENDCLASS.
