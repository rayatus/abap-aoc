CLASS ltcl_aoc_day3_1 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      example_test FOR TESTING RAISING cx_static_check,
      calc_expand_times_11_lines_tst FOR TESTING RAISING cx_static_check,
      calc_expand_times_2_lines_tst FOR TESTING RAISING cx_static_check,
      expand_input_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_aoc_day3_1 IMPLEMENTATION.

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
    DATA(cut) = NEW zcl_aoc_2020_day3_1(  ).
    cut->set_input( input ).
    cut->run(  ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_result(  ) exp = 7 ).

  ENDMETHOD.

  METHOD calc_expand_times_11_lines_tst.
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
    DATA(cut) = NEW zcl_aoc_2020_day3_1(  ).
    cut->set_input( input ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->calculate_expand_times(  ) exp = 4 ).

  ENDMETHOD.

  METHOD expand_input_test.
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
    DATA(cut) = NEW zcl_aoc_2020_day3_1(  ).
    cut->set_input( input ).
    cut->prepare_expanded_input( cut->calculate_expand_times(  ) ).

    "Then
    DATA(expanded_input) = NEW zcl_aoc_input_helper(  ).
    expanded_input->add( |..##.......| && |..##.......| && |..##.......| && |..##.......| ).
    expanded_input->add( |#...#...#..| && |#...#...#..| && |#...#...#..| && |#...#...#..| ).
    expanded_input->add( |.#....#..#.| && |.#....#..#.| && |.#....#..#.| && |.#....#..#.| ).
    expanded_input->add( |..#.#...#.#| && |..#.#...#.#| && |..#.#...#.#| && |..#.#...#.#| ).
    expanded_input->add( |.#...##..#.| && |.#...##..#.| && |.#...##..#.| && |.#...##..#.| ).
    expanded_input->add( |..#.##.....| && |..#.##.....| && |..#.##.....| && |..#.##.....| ).
    expanded_input->add( |.#.#.#....#| && |.#.#.#....#| && |.#.#.#....#| && |.#.#.#....#| ).
    expanded_input->add( |.#........#| && |.#........#| && |.#........#| && |.#........#| ).
    expanded_input->add( |#.##...#...| && |#.##...#...| && |#.##...#...| && |#.##...#...| ).
    expanded_input->add( |#...##....#| && |#...##....#| && |#...##....#| && |#...##....#| ).
    expanded_input->add( |.#..#...#.#| && |.#..#...#.#| && |.#..#...#.#| && |.#..#...#.#| ).

    cl_abap_unit_assert=>assert_equals( act = cut->get_input(  )->get_all_values( )
                                        exp = expanded_input->get_all_values( ) ).
  ENDMETHOD.

  METHOD calc_expand_times_2_lines_tst.
    "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( |..##.......| ).
    input->add( |#...#...#..| ).

    "When
    DATA(cut) = NEW zcl_aoc_2020_day3_1(  ).
    cut->set_input( input ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->calculate_expand_times(  ) exp = 0 ).
  ENDMETHOD.

ENDCLASS.
