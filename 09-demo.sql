call p_case_no_found(100);

call P_CURSOR_ALREADY_OPEN();

call P_DUP_VAL_ON_INDEX('test1','90909');

call P_INVALID_CURSOR();

call P_INVALID_NUMBER('a');

call P_CUSTOM_EXCEPTION(2, '123');
