module tb_fpga();
	// Test ports
	reg A, B;
	reg carryin;
	wire out;
	wire carryout;
	// Configuration ports
	reg [749:0] brbselect;
	reg [1727:0] bsbselect;
	reg [79:0] lbselect;
	reg [19:0] leftioselect;
	reg [19:0] rightioselect;
	reg [19:0] topioselect;
	reg [19:0] bottomioselect;

	wire [4:0] left, right, top, bottom;

	fpga_top f1(
		clk, 
		brbselect, bsbselect, lbselect, 
		leftioselect, rightioselect, topioselect, bottomioselect, 
		left, right, top, bottom
	);
	reg k;
	initial begin
		brbselect = 750'b0;
		bsbselect = 1728'b0;
		lbselect = 80'b0;
		leftioselect = 20'b0;
		rightioselect = 20'b0;
		topioselect = 20'b0;
		bottomioselect = 20'b0;
		/*for (k = 0; k < 750; k = k + 1)
		begin
			brbselect[k] = 1'b0;
		end
		for (k = 0; k < 1728; k = k + 1)
		begin
			bsbselect[k] = 1'b0;
		end
		for (k = 0; k < 80; k = k + 1)
		begin
			lbselect[k] = 1'b0;
		end
		for (k = 0; k < 20; k = k + 1)
		begin
			leftioselect[k] = 1'b0;
			rightioselect[k] = 1'b0;
			topioselect[k] = 1'b0;
			bottomioselect[k] = 1'b0;
		end*/
		$display("initialized memory");
		// #10 select = 4'b0000;
		set_bottom_io_cfg(0, 0, 1); // Bottom left in
		set_top_io_cfg(0, 0, 2); // Top left out
		set_brb_cfg(0, 0, 0, 3, 2);
		set_brb_cfg(1, 0, 0, 3, 2);
		set_brb_cfg(2, 0, 0, 3, 2);
		set_brb_cfg(3, 0, 0, 3, 2);
		set_brb_cfg(4, 0, 0, 3, 2);

		A = 1'b0; B = 1'b0; carryin = 1'b0;
		$monitor("A = %b, B = %b, carryin = %b, out = %b, carryout = %b",
				A, B, carryin, out, carryout);
		#10 A = 1'b0; B = 1'b0; carryin = 1'b0;
		#10 A = 1'b1; B = 1'b0; carryin = 1'b0;
		#10 A = 1'b0; B = 1'b1; carryin = 1'b0;
		#10 A = 1'b1; B = 1'b1; carryin = 1'b0;
		#10 A = 1'b0; B = 1'b0; carryin = 1'b1;
		#10 A = 1'b1; B = 1'b0; carryin = 1'b1;
		#10 A = 1'b0; B = 1'b1; carryin = 1'b1;
		#10 A = 1'b1; B = 1'b1; carryin = 1'b1;
	end
	task set_top_io_cfg;
		input io_index, io_line, io_dir;
		begin
			if (io_line == 0) begin
				topioselect[io_index*4] = 1'b0;
				topioselect[io_index*4+1] = 1'b0;
			end else if (io_line == 1) begin
				topioselect[io_index*4] = 1'b1;
				topioselect[io_index*4+1] = 1'b0;
			end else if (io_line == 1) begin
				topioselect[io_index*4] = 1'b0;
				topioselect[io_index*4+1] = 1'b1;
			end

			if (io_dir == 0) begin // Off
				topioselect[io_index*4+2] = 1'b0;
				topioselect[io_index*4+3] = 1'b0;
			end else if (io_dir == 1) begin // In
				topioselect[io_index*4+2] = 1'b0;
				topioselect[io_index*4+3] = 1'b1;
			end else if (io_dir == 2) begin // Out
				topioselect[io_index*4+2] = 1'b1;
				topioselect[io_index*4+3] = 1'b0;
			end
		end
	endtask

	task set_bottom_io_cfg;
		input io_index, io_line, io_dir;
		begin
			if (io_line == 0) begin
				bottomioselect[io_index*4] = 1'b0;
				bottomioselect[io_index*4+1] = 1'b0;
			end else if (io_line == 1) begin
				bottomioselect[io_index*4] = 1'b1;
				bottomioselect[io_index*4+1] = 1'b0;
			end else if (io_line == 1) begin
				bottomioselect[io_index*4] = 1'b0;
				bottomioselect[io_index*4+1] = 1'b1;
			end

			if (io_dir == 0) begin // Off
				bottomioselect[io_index*4+2] = 1'b0;
				bottomioselect[io_index*4+3] = 1'b0;
			end else if (io_dir == 1) begin // In
				bottomioselect[io_index*4+2] = 1'b0;
				bottomioselect[io_index*4+3] = 1'b1;
			end else if (io_dir == 2) begin // Out
				bottomioselect[io_index*4+2] = 1'b1;
				bottomioselect[io_index*4+3] = 1'b0;
			end
		end
	endtask

	task set_left_io_cfg;
		input io_index, io_line, io_dir;
		begin
			if (io_line == 0) begin
				leftioselect[io_index*4] = 1'b0;
				leftioselect[io_index*4+1] = 1'b0;
			end else if (io_line == 1) begin
				leftioselect[io_index*4] = 1'b1;
				leftioselect[io_index*4+1] = 1'b0;
			end else if (io_line == 1) begin
				leftioselect[io_index*4] = 1'b0;
				leftioselect[io_index*4+1] = 1'b1;
			end

			if (io_dir == 0) begin // Off
				leftioselect[io_index*4+2] = 1'b0;
				leftioselect[io_index*4+3] = 1'b0;
			end else if (io_dir == 1) begin // In
				leftioselect[io_index*4+2] = 1'b0;
				leftioselect[io_index*4+3] = 1'b1;
			end else if (io_dir == 2) begin // Out
				leftioselect[io_index*4+2] = 1'b1;
				leftioselect[io_index*4+3] = 1'b0;
			end
		end
	endtask

	task set_right_io_cfg;
		input io_index, io_line, io_dir;
		begin
			if (io_line == 0) begin
				rightioselect[io_index*4] = 1'b0;
				rightioselect[io_index*4+1] = 1'b0;
			end else if (io_line == 1) begin
				rightioselect[io_index*4] = 1'b1;
				rightioselect[io_index*4+1] = 1'b0;
			end else if (io_line == 1) begin
				rightioselect[io_index*4] = 1'b0;
				rightioselect[io_index*4+1] = 1'b1;
			end

			if (io_dir == 0) begin // Off
				rightioselect[io_index*4+2] = 1'b0;
				rightioselect[io_index*4+3] = 1'b0;
			end else if (io_dir == 1) begin // In
				rightioselect[io_index*4+2] = 1'b0;
				rightioselect[io_index*4+3] = 1'b1;
			end else if (io_dir == 2) begin // Out
				rightioselect[io_index*4+2] = 1'b1;
				rightioselect[io_index*4+3] = 1'b0;
			end
		end
	endtask

	task set_brb_cfg;
		input row, col;
		// which switch element, which internal switch
		input s_index, s_sel;
		input dir;
		begin
			if (dir == 0) begin // Off
				brbselect[col*36 + row*180 + s_index*12 + s_sel*2] = 1'b0;
				brbselect[col*36 + row*180 + s_index*12 + s_sel*2 + 1] = 1'b0;
			end else if (dir == 1) begin // In
				brbselect[col*36 + row*180 + s_index*12 + s_sel*2] = 1'b0;
				brbselect[col*36 + row*180 + s_index*12 + s_sel*2 + 1] = 1'b1;
			end else if (dir == 2) begin // Out
				brbselect[col*36 + row*180 + s_index*12 + s_sel*2] = 1'b1;
				brbselect[col*36 + row*180 + s_index*12 + s_sel*2 + 1] = 1'b0;
			end
		end
	endtask

	task set_bsb_cfg;
		input row, col;
		// which switch element, which internal switch
		input s_row, s_col, s_sel;
		input dir;
		begin
			if (dir == 0) begin // Off
				bsbselect[col*108 + row*432 + s_col*12 + s_row*36 + s_sel*2] = 1'b0;
				bsbselect[col*108 + row*432 + s_col*12 + s_row*36 + s_sel*2 + 1] = 1'b0;
			end else if (dir == 1) begin // In
				bsbselect[col*108 + row*432 + s_col*12 + s_row*36 + s_sel*2] = 1'b0;
				bsbselect[col*108 + row*432 + s_col*12 + s_row*36 + s_sel*2 + 1] = 1'b1;
			end else if (dir == 2) begin // Out
				bsbselect[col*108 + row*432 + s_col*12 + s_row*36 + s_sel*2] = 1'b1;
				bsbselect[col*108 + row*432 + s_col*12 + s_row*36 + s_sel*2 + 1] = 1'b0;
			end
		end
	endtask

	task set_lb_cfg;
		input row, col;
		input [3:0] truth_tbl;
		input sync;
		begin
			lbselect[col*5 + row * 20] = truth_tbl[0];
			lbselect[col*5 + row * 20 + 1] = truth_tbl[1];
			lbselect[col*5 + row * 20 + 2] = truth_tbl[2];
			lbselect[col*5 + row * 20 + 3] = truth_tbl[3];
			lbselect[col*5 + row * 20 + 4] = sync;
		end
	endtask

endmodule
