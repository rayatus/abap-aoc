CLASS zcl_aoc_2020_day1_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
    INHERITING FROM zcl_aoc_2020_base.



  PUBLIC SECTION.

    TYPES: BEGIN OF mtyp_s_solution_1,
             result TYPE i,
             value1 TYPE i,
             value2 TYPE i,
           END   OF mtyp_s_solution_1.

    DATA: ms_solution_1 TYPE mtyp_s_solution_1 READ-ONLY.

    METHODS:
      zif_aoc_problem~run REDEFINITION,
      zif_aoc_problem~print REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_aoc_2020_day1_1 IMPLEMENTATION.
  METHOD zif_aoc_problem~print.
    IF ms_solution_1 IS NOT INITIAL.
      io_out->write( condense( |Found values { ms_solution_1-value1 } and { ms_solution_1-value2 } which multiplied results in { ms_solution_1-result }| ) ).
    ELSE.
      io_out->write( |No solution has been found. :_(| ).
    ENDIF.
  ENDMETHOD.

  METHOD zif_aoc_problem~run.

    "Let's find 2 entries which sum is 2020
    "we suppose that there's only 2 values which sum 2020 and no duplicate numbers

    DATA lt_sorted_values TYPE SORTED TABLE OF i WITH UNIQUE KEY table_line.

    lt_sorted_values[] = mo_input_helper->get_all_values( ).

    DATA(lf_found) = abap_false.
    DATA(j) = 0.
    WHILE j < lines( lt_sorted_values ) AND lf_found = abap_false.
      j = j + 1.

      ms_solution_1-value1 = lt_sorted_values[ j ].
      ms_solution_1-value2 = 2020 - ms_solution_1-value1.
      IF line_exists( lt_sorted_values[ table_line = ms_solution_1-value2 ] ).
        lf_found = abap_true.
        ms_solution_1-result = ms_solution_1-value1 * ms_solution_1-value2.
      ENDIF.
    ENDWHILE.
    IF lf_found = abap_false.
      CLEAR ms_solution_1.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
