CLASS zcl_aoc_2020_day1_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
   INHERITING FROM zcl_aoc_2020_base.



  PUBLIC SECTION.

    TYPES: BEGIN OF mtyp_s_pair_values,
             value1 TYPE i,
             value2 TYPE i,
           END   OF mtyp_s_pair_values,

           mtyp_t_values TYPE STANDARD TABLE OF i WITH NON-UNIQUE KEY table_line,

           BEGIN OF mtyp_s_solution,
             result TYPE i,
             values TYPE mtyp_t_values,
           END   OF mtyp_s_solution.

    DATA: ms_solution TYPE mtyp_s_solution READ-ONLY.

    METHODS:
      zif_aoc_problem~run REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS find_difference_pair_values IMPORTING id_index             TYPE i
                                                  id_sum               TYPE i
                                        RETURNING VALUE(rs_pair_value) TYPE mtyp_s_pair_values.

ENDCLASS.



CLASS zcl_aoc_2020_day1_2 IMPLEMENTATION.

  METHOD zif_aoc_problem~run.

    "Let's find 3 numbers which sum is 2020

    DATA lt_sorted_values TYPE SORTED TABLE OF i WITH UNIQUE KEY table_line.
    DATA ls_pair_value TYPE mtyp_s_pair_values.

    lt_sorted_values[] = get_input( )->get_all_values( ).

    DATA(lf_found) = abap_false.
    DATA(j) = 0.
    WHILE j < lines( lt_sorted_values ) AND lf_found = abap_false.
      j = j + 1.

      DATA(ld_this_value) = lt_sorted_values[ j ].
      ls_pair_value = find_difference_pair_values( id_index = j
                                                   id_sum   = ( abs( ld_this_value - 2020 ) ) ).
      IF ls_pair_value IS NOT INITIAL.
        lf_found = abap_true.
        INSERT ld_this_value INTO TABLE ms_solution-values.
        INSERT ls_pair_value-value1 INTO TABLE ms_solution-values.
        INSERT ls_pair_value-value2 INTO TABLE ms_solution-values.
      ENDIF.

    ENDWHILE.

    IF ms_solution-values IS NOT INITIAL.
      ms_solution-result = 1.
      LOOP AT ms_solution-values INTO DATA(ld_value).
        ms_solution-result = ms_solution-result * ld_value.
      ENDLOOP.
    ENDIF.

    set_result( conv #( ms_solution-result ) ).
  ENDMETHOD.


  METHOD find_difference_pair_values.

    DATA lt_sorted_values TYPE SORTED TABLE OF i WITH UNIQUE KEY table_line.
    lt_sorted_values[] = get_input( )->get_all_values( ).

    DATA(lf_found) = abap_false.
    DATA(j) = id_index.
    WHILE j < lines( lt_sorted_values ) AND lf_found = abap_false.
      j = j + 1.

      DATA(ld_this_value) = lt_sorted_values[ j ].
      DATA(ld_rest)       = abs( id_sum - ld_this_value ).
      IF line_exists( lt_sorted_values[ table_line = ld_rest ] ).
        lf_found             = abap_true.
        rs_pair_value-value1 = ld_this_value.
        rs_pair_value-value2 = ld_rest.
      ENDIF.

    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
