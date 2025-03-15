module process_demo;
    process proc[4];
    
  task automatic wait_on_time(int timer, int proc_name);
    $display("%t, going to wait on process timer %d, for process %d", $time, timer, proc_name);
    #timer;
    $display("%t, Done waiting on process timer %d, for process %d", $time, timer, proc_name);
  endtask
             
    initial begin
        for (int i=0; i<4; ++i) begin
            fork
                automatic int k = i;
                begin
                  
                   proc[k] = process::self();
                   wait_on_time((k+1)*10, k);
                                     
                end
            join_none
            //#2;
        end

        //  wait for all process to start
        for (int i=0; i<4; ++i) begin
            wait(proc[i] != null);
        end
        $display("[%0t]All process started", $time);
 
        //  suspend proc[1] until proc[3] is finished
        proc[1].suspend();
        #1;
        $display("[%0t] Status of proc 1 = %s", $time, proc[1].status().name());

        //  waits for the proc[2] to finish
        proc[3].await();

        $display("[%0t] Status of proc 1 = %s", $time, proc[1].status().name());
        //  resumes proc[1]
        proc[1].resume();
        $display("[%0t] Status of proc 1 = %s", $time, proc[1].status().name());

        //  kill all process
        #20;
        $display("[%0t] Killing all process", $time);
        for (int i=0; i<4; ++i) begin
            if(proc[i].status() != process::FINISHED)
                proc[i].kill();
        end
        $display("[%0t] Killed all process", $time);

        //  prints status of all the processes after killing them
        //  while killing a process we first check whether process
        //  is finished or not
        #2;
        $display("Status of all processes");
        $display("[%0t] Status of proc 0 = %s", $time, proc[0].status().name());
        $display("[%0t] Status of proc 1 = %s", $time, proc[1].status().name());
        $display("[%0t] Status of proc 2 = %s", $time, proc[2].status().name());
        $display("[%0t] Status of proc 3 = %s", $time, proc[3].status().name());
        // #120;
        $finish();
    end
endmodule
