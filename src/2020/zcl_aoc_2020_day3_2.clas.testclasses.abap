CLASS ltcl_aoc_day3_2 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      run_right_1_down_1_test FOR TESTING RAISING cx_static_check,
      run_right_3_down_1_test FOR TESTING RAISING cx_static_check,
      run_right_5_down_1_test FOR TESTING RAISING cx_static_check,
      run_right_7_down_1_test FOR TESTING RAISING cx_static_check,
      run_right_1_down_2_test FOR TESTING RAISING cx_static_check,
      example_test FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_aoc_day3_2 IMPLEMENTATION.

  METHOD run_right_1_down_1_test.
    "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( |..##.......| ).
    input->add( |#...#...#..| ).
    input->add( |.#....#..#.| ).
    input->add( |..#.#...#.#| ).
    input->add( |.#...##..#.| ).
    input->add( |..#.##.....| ).
    input->add( |.#.#.#....#| ).
    input->add( |.#........#| ).
    input->add( |#.##...#...| ).
    input->add( |#...##....#| ).
    input->add( |.#..#...#.#| ).

    "When
    DATA(cut) = NEW zcl_aoc_2020_day3_2(  ).
    cut->set_input( input ).
    cut->run_per_movement( id_rigth = 1 id_down = 1 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_result(  ) exp = 2 ).

  ENDMETHOD.



  METHOD run_right_1_down_2_test.
    "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( |..##.......| ).
    input->add( |#...#...#..| ).
    input->add( |.#....#..#.| ).
    input->add( |..#.#...#.#| ).
    input->add( |.#...##..#.| ).
    input->add( |..#.##.....| ).
    input->add( |.#.#.#....#| ).
    input->add( |.#........#| ).
    input->add( |#.##...#...| ).
    input->add( |#...##....#| ).
    input->add( |.#..#...#.#| ).

    "When
    DATA(cut) = NEW zcl_aoc_2020_day3_2(  ).
    cut->set_input( input ).
    cut->run_per_movement( id_rigth = 1 id_down = 2 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_result(  ) exp = 2 ).

  ENDMETHOD.

  METHOD run_right_3_down_1_test.
    "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( |..##.......| ).
    input->add( |#...#...#..| ).
    input->add( |.#....#..#.| ).
    input->add( |..#.#...#.#| ).
    input->add( |.#...##..#.| ).
    input->add( |..#.##.....| ).
    input->add( |.#.#.#....#| ).
    input->add( |.#........#| ).
    input->add( |#.##...#...| ).
    input->add( |#...##....#| ).
    input->add( |.#..#...#.#| ).

    "When
    DATA(cut) = NEW zcl_aoc_2020_day3_2(  ).
    cut->set_input( input ).
    cut->run_per_movement( id_rigth = 3 id_down = 1 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_result(  ) exp = 7 ).

  ENDMETHOD.

  METHOD run_right_5_down_1_test.
    "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( |..##.......| ).
    input->add( |#...#...#..| ).
    input->add( |.#....#..#.| ).
    input->add( |..#.#...#.#| ).
    input->add( |.#...##..#.| ).
    input->add( |..#.##.....| ).
    input->add( |.#.#.#....#| ).
    input->add( |.#........#| ).
    input->add( |#.##...#...| ).
    input->add( |#...##....#| ).
    input->add( |.#..#...#.#| ).

    "When
    DATA(cut) = NEW zcl_aoc_2020_day3_2(  ).
    cut->set_input( input ).
    cut->run_per_movement( id_rigth = 5 id_down = 1 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_result(  ) exp = 3 ).

  ENDMETHOD.

  METHOD run_right_7_down_1_test.
    "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( |..##.......| ).
    input->add( |#...#...#..| ).
    input->add( |.#....#..#.| ).
    input->add( |..#.#...#.#| ).
    input->add( |.#...##..#.| ).
    input->add( |..#.##.....| ).
    input->add( |.#.#.#....#| ).
    input->add( |.#........#| ).
    input->add( |#.##...#...| ).
    input->add( |#...##....#| ).
    input->add( |.#..#...#.#| ).

    "When
    DATA(cut) = NEW zcl_aoc_2020_day3_2(  ).
    cut->set_input( input ).
    cut->run_per_movement( id_rigth = 7 id_down = 1 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_result(  ) exp = 4 ).

  ENDMETHOD.

  METHOD example_test.
  "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( |..##.......| ).
    input->add( |#...#...#..| ).
    input->add( |.#....#..#.| ).
    input->add( |..#.#...#.#| ).
    input->add( |.#...##..#.| ).
    input->add( |..#.##.....| ).
    input->add( |.#.#.#....#| ).
    input->add( |.#........#| ).
    input->add( |#.##...#...| ).
    input->add( |#...##....#| ).
    input->add( |.#..#...#.#| ).

    "When
    DATA(cut) = NEW zcl_aoc_2020_day3_2(  ).
    cut->set_input( input ).
    cut->run(  ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_result(  ) exp = 336 ).
  ENDMETHOD.

ENDCLASS.
