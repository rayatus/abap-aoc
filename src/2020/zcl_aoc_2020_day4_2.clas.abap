"! <p class="shorttext synchronized" lang="en">Advents of Code : 2020 - Day 4 / Problem 2</p>
CLASS zcl_aoc_2020_day4_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_2020_base.

  PUBLIC SECTION.

    METHODS:
      zif_aoc_problem~run REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS: BEGIN OF mc_passport_key,
                 birth_year      TYPE string VALUE 'byr',
                 issue_year      TYPE string VALUE 'iyr',
                 expiration_year TYPE string VALUE 'eyr',
                 height          TYPE string VALUE 'hgt',
                 hair_color      TYPE string VALUE 'hcl',
                 eye_color       TYPE string VALUE 'ecl',
                 passport_id     TYPE string VALUE 'pid',
                 country_id      TYPE string VALUE 'cid',
               END   OF mc_passport_key.

    TYPES: BEGIN OF mtyp_s_passport,
             birth_year      TYPE string,
             issue_year      TYPE string,
             expiration_year TYPE string,
             height          TYPE string,
             hair_color      TYPE string,
             eye_color       TYPE string,
             passport_id     TYPE string,
             country_id      TYPE string,
           END OF mtyp_s_passport,
           mtyp_t_passports TYPE STANDARD TABLE OF mtyp_s_passport.

    DATA mt_passports TYPE mtyp_t_passports.

    METHODS map_data_into_passport
      IMPORTING
        id_data     TYPE any
      CHANGING
        cs_passport TYPE zcl_aoc_2020_day4_2=>mtyp_s_passport.

    METHODS get_passports_from_input.
    METHODS validate_passports.

    METHODS is_valid_birth_year
      IMPORTING id_birth_year      TYPE zcl_aoc_2020_day4_2=>mtyp_s_passport-birth_year
      RETURNING VALUE(rf_is_valid) TYPE xfeld.

    METHODS is_valid_issue_year
      IMPORTING id_issue_year      TYPE zcl_aoc_2020_day4_2=>mtyp_s_passport-issue_year
      RETURNING VALUE(rf_is_valid) TYPE xfeld.

    METHODS is_valid_expiration_year
      IMPORTING id_expiration_year TYPE zcl_aoc_2020_day4_2=>mtyp_s_passport-expiration_year
      RETURNING VALUE(rf_is_valid) TYPE xfeld.

    METHODS is_valid_height
      IMPORTING VALUE(id_height)   TYPE zcl_aoc_2020_day4_2=>mtyp_s_passport-height
      RETURNING VALUE(rf_is_valid) TYPE xfeld.
    METHODS is_valid_hair_color
      IMPORTING id_hair_color      TYPE zcl_aoc_2020_day4_2=>mtyp_s_passport-hair_color
      RETURNING VALUE(rf_is_valid) TYPE xfeld.

    METHODS is_valid_eye_color
      IMPORTING id_eye_color       TYPE zcl_aoc_2020_day4_2=>mtyp_s_passport-eye_color
      RETURNING VALUE(rf_is_valid) TYPE xfeld.

    METHODS is_valid_passport_id
      IMPORTING id_passport_id     TYPE zcl_aoc_2020_day4_2=>mtyp_s_passport-passport_id
      RETURNING VALUE(rf_is_valid) TYPE xfeld.

    METHODS is_valid_country_id
      IMPORTING id_country_id      TYPE zcl_aoc_2020_day4_2=>mtyp_s_passport-country_id
      RETURNING VALUE(rf_is_valid) TYPE xfeld.

ENDCLASS.



CLASS zcl_aoc_2020_day4_2 IMPLEMENTATION.


  METHOD zif_aoc_problem~run.

    get_passports_from_input( ).
    validate_passports(  ).

  ENDMETHOD.


  METHOD map_data_into_passport.
    DATA lt_key_pairs TYPE string_table.

    SPLIT id_data AT space INTO TABLE lt_key_pairs.
    LOOP AT lt_key_pairs INTO DATA(ls_key_pair).
      SPLIT ls_key_pair AT ':' INTO DATA(ld_key) DATA(ld_value).

      CASE ld_key.
        WHEN mc_passport_key-birth_year.
          cs_passport-birth_year = ld_value.
        WHEN mc_passport_key-country_id.
          cs_passport-country_id = ld_value.
        WHEN mc_passport_key-expiration_year.
          cs_passport-expiration_year = ld_value.
        WHEN mc_passport_key-eye_color.
          cs_passport-eye_color = ld_value.
        WHEN mc_passport_key-hair_color.
          cs_passport-hair_color = ld_value.
        WHEN mc_passport_key-height.
          cs_passport-height = ld_value.
        WHEN mc_passport_key-issue_year.
          cs_passport-issue_year = ld_value.
        WHEN mc_passport_key-passport_id.
          cs_passport-passport_id = ld_value.
      ENDCASE.

    ENDLOOP.

  ENDMETHOD.


  METHOD get_passports_from_input.

    DATA ls_passport TYPE mtyp_s_passport.


    WHILE get_input(  )->has_next(  ).
      DATA(ld_data) = get_input(  )->next(  ).
      IF  ld_data IS INITIAL.
        INSERT ls_passport INTO TABLE mt_passports.
        CLEAR ls_passport.
      ELSE.
        map_data_into_passport( EXPORTING id_data = ld_data
                                CHANGING  cs_passport = ls_passport ).
      ENDIF.
    ENDWHILE.
    IF ls_passport IS NOT INITIAL.
      INSERT ls_passport INTO TABLE mt_passports.
    ENDIF.

  ENDMETHOD.


  METHOD validate_passports.
    set_result( 0 ).

    LOOP AT mt_passports INTO DATA(ls_passport).
      DATA(ld_empty_fields) = 0.
      DATA(ld_counter) = 0.

      IF is_valid_birth_year( ls_passport-birth_year ) = abap_false.
        CLEAR ls_passport-birth_year.
      ENDIF.
      IF is_valid_country_id( ls_passport-country_id ) = abap_false.
        CLEAR ls_passport-country_id.
      ENDIF.

      IF is_valid_expiration_year( ls_passport-expiration_year ) = abap_false.
        CLEAR ls_passport-expiration_year.
      ENDIF.
      IF is_valid_eye_color( ls_passport-eye_color ) = abap_false.
        CLEAR ls_passport-eye_color.
      ENDIF.
      IF is_valid_hair_color( ls_passport-hair_color ) = abap_false.
        CLEAR ls_passport-hair_color.
      ENDIF.
      IF is_valid_height( ls_passport-height ) = abap_false.
        CLEAR ls_passport-height.
      ENDIF.
      IF is_valid_issue_year( ls_passport-issue_year ) = abap_false.
        CLEAR ls_passport-issue_year.
      ENDIF.
      IF is_valid_passport_id( ls_passport-passport_id ) = abap_false.
        CLEAR ls_passport-passport_id.
      ENDIF.


      DO.
        ADD 1 TO ld_counter.
        ASSIGN COMPONENT ld_counter OF STRUCTURE ls_passport TO FIELD-SYMBOL(<ls_value>).
        IF sy-subrc IS INITIAL.
          IF <ls_value> IS INITIAL.
            ADD 1 TO ld_empty_fields.
          ENDIF.
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.

      IF ls_passport-country_id IS INITIAL.
        SUBTRACT 1 FROM ld_empty_fields.
      ENDIF.

      IF ld_empty_fields = 0.
        set_result( get_result(  ) + 1 ).
      ENDIF.

    ENDLOOP.



  ENDMETHOD.


  METHOD is_valid_birth_year.

    DATA(ld_lenght) = strlen( condense( id_birth_year ) ).
    IF ( id_birth_year BETWEEN 1920 AND 2002 ) AND ld_lenght = 4.
      rf_is_valid = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD is_valid_country_id.
    rf_is_valid = abap_true.
  ENDMETHOD.

  METHOD is_valid_expiration_year.
    DATA(ld_lenght) = strlen( condense( id_expiration_year ) ).
    IF ( id_expiration_year BETWEEN 2020 AND 2030 ) AND ld_lenght = 4.
      rf_is_valid = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD is_valid_eye_color.
    CASE id_eye_color.
      WHEN  'amb' OR 'blu' OR 'brn' OR 'gry' OR 'grn' OR 'hzl' OR 'oth'.
        rf_is_valid = abap_true.
      WHEN OTHERS.
        rf_is_valid = abap_false.
    ENDCASE.
  ENDMETHOD.

  METHOD is_valid_hair_color.

    rf_is_valid = abap_false.

    IF  strlen( id_hair_color ) = 7
    AND id_hair_color+0(1) = '#'
    AND id_hair_color+1(6) CO '0123456789abcdef'.
      rf_is_valid = abap_true.
    ENDIF.

  ENDMETHOD.

  METHOD is_valid_height.
    rf_is_valid = abap_false.

    IF id_height CS 'cm'.
      REPLACE 'cm' WITH space INTO id_height.
      CONDENSE id_height.
      IF id_height BETWEEN 150 AND 193.
        rf_is_valid = abap_true.
      ENDIF.
    ENDIF.

    IF id_height CS 'in'.
      REPLACE 'in' WITH space INTO id_height.
      CONDENSE id_height.
      IF id_height BETWEEN 59 AND 76.
        rf_is_valid = abap_true.
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD is_valid_issue_year.
    DATA(ld_length) = strlen( condense( id_issue_year ) ).
    IF ( id_issue_year BETWEEN 2010 AND 2020 ) AND ld_length = 4.
      rf_is_valid = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD is_valid_passport_id.

    IF strlen( condense( id_passport_id ) ) = 9 AND id_passport_id CO '0123456789'.
      rf_is_valid = abap_true.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
