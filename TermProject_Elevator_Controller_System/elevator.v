`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Sabanci University CS303 Term Project
// Elevator Control System
// ------------------------------------- 
// Engineers: Berna Yildiran & Taha Can Karaman
//////////////////////////////////////////////////////////////////////////////////

// Dunyanin en iyi projesi

module elevator( 
input clk_in,  rst,  
floor_0_p,  
floor_1_p, 
floor_2_p,  
floor_3_p,  
floor_4_p,  

direction_1,  
direction_2,  
direction_3,

floor_0_d,  
floor_1_d,  
floor_2_d,  
floor_3_d,  
floor_4_d,

output reg led_inside_0, 
led_inside_1, 
led_inside_2,  
led_inside_3, 
led_inside_4,

led_outside_0,   
led_outside_1,   
led_outside_2,  
led_outside_3,  
led_outside_4,

led_busy,

reg [7:0] a, b, c, d, e, f, g, p
);

// ==================================================================================================== 
// Declare internal registers for the state, current floor, and next floor
reg [1:0] state;
reg [2:0] currentFloor;
reg [2:0] nextFloor;

// ====================================================================================================
// Declare registers for wait time, inside and outside LED signals, and button press checks
reg waitTime;
reg [4:0] ledInside;
reg [4:0] ledOutside;
reg [4:0] buttonCheck;
reg [7:0] counter;

// ==================================================================================================== 
// Handle the elevator's [STATE] and movement
always@(posedge clk_in or negedge rst)
begin

    // If reset is active, set the state to 0
    if(!rst)
        state <= 0;
    
    // If not in reset, 
    // check currentFloor, next floor, ledInside and ledOutside signals to determine the state
    else begin
    
        // If the current floor is the same as the next floor and the LED signals are off, 
        // set the state to 0 (idle)
        if((ledInside == 0) && (ledOutside == 0) && !led_busy && (currentFloor == nextFloor)) 
            state <= 0;
        
        // If the next floor is higher than the current floor, 
        // set the state to 1 (moving up)
        else if(nextFloor > currentFloor)
            state <= 1;
        
        // If the next floor is lower than the current floor, 
        // set the state to 2 (moving down)
        else if(nextFloor < currentFloor)
            state <= 2;

        else begin end
    end
end

// ====================================================================================================
// Handle the elevator's [WAIT TIME] and movement
always@(posedge clk_in or negedge rst)
begin

    // If reset is active, set the waitTime and count registers to 0, 
    // and set the led_busy signal to 0
    if(!rst) begin
        led_busy <= 0;
        waitTime <= 0;
        currentFloor <= 0;
        counter <= 0;
    end
    
    else begin
    
        // If the elevator is waiting at a floor, 
        // increment the counter register until it reaches 250
        if(waitTime == 1) begin
            
            // Once the counter reaches 250, reset the waitTime, counter, and led_busy signal (wait for 5 seconds)
            if(counter == 250) // 250 * 20 ms = 5000 ms = 5 seconds
            begin
                led_busy <= 0;
                waitTime <= 0;
                counter <= 0;
                
                // If the elevator's state is moving up 
                // and the next floor is higher than the current floor,
                // move to the next floor
                if((state == 1) && !led_busy && (nextFloor > currentFloor))                                             
                    currentFloor <= currentFloor+1;
                else begin end
                // If the elevator's state is moving down
                // and the next floor is lower than the current floor, 
                // move to the next floor
                if((state == 2) && !led_busy && (nextFloor < currentFloor))
                    currentFloor <= currentFloor-1;

                else begin end
            end
            
            // If the counter is less than 250, increment the counter register
            else 
                counter <= counter+1;        
        end
        
        // If the elevator is not waiting, 
        // check the ledInside and ledOutside signals for the current floor 
        // to determine if the elevator is busy
        else begin
            // Floor 0
            if(currentFloor == 0 && (ledInside[0]||ledOutside[0]))
                led_busy <= 1;
            // Floor 1
            else if(currentFloor == 1 && (ledInside[1]||ledOutside[1]))
                led_busy <= 1;              
            // Floor 2
            else if(currentFloor == 2 && (ledInside[2]||ledOutside[2]))
                led_busy <= 1;
            // Floor 3
            else if(currentFloor == 3 && (ledInside[3]||ledOutside[3]))
                led_busy <= 1;
            // Floor 4
            else if(currentFloor == 4 && (ledInside[4]||ledOutside[4]))
                led_busy <= 1;
            // If the elevator is not busy, set the wait time register to 1
            else begin end
            waitTime <= 1;
        end
    end
 end
 
// ====================================================================================================
// Handle the elevator's ledInside and ledOutside signals
always @(posedge clk_in or negedge rst)
begin
    
    // If reset is active, 
    // set the ledInside and ledOutside registers to 0
    if(!rst) begin
        ledInside <= 0;
        ledOutside <= 0;
    end
    else begin
        // Check for button presses on floor 0
        if(!floor_0_d) 
            buttonCheck[0] <= 0;
        else begin end
        // Check for button presses on floor 1
        if(!floor_1_d) 
            buttonCheck[1] <= 0;
        else begin end
        // Check for button presses on floor 2
        if(!floor_2_d) 
            buttonCheck[2] <= 0;
        else begin end
        // Check for button presses on floor 3
        if(!floor_3_d) 
            buttonCheck[3] <= 0;
        else begin end
        // Check for button presses on floor 4
        if(!floor_4_d) 
            buttonCheck[4] <= 0;
        else begin end
        
        // ------------------------------------------------------------------------------
        // BUTTONS PRESSED
        // ------------------------------------------------------------------------------
        // Check if the button on floor 0 is pressed
        if(floor_0_p) begin
            // Check if the elevator is at floor 0 or moving towards floor 0 (redundant as we don't have any basement levels (no -1,-2 levels))
            if(((state == 0)&& currentFloor != 0)
            ||((state==1)&&(nextFloor>=0)&&(currentFloor<0)) // not necessary as currentFloor will never be lower than 0, but doesn't affect function
            ||((state==2)&&(nextFloor<=0)&&(currentFloor>0))) 
                ledOutside[0] <=1;
            else begin end  
        end
        else begin end

        // Check if the button on floor 1 is pressed
        if(floor_1_p) begin
            // check if the elevator is at floor 1 or moving towards floor 1 in the correct direction
            if(((state == 0)&& currentFloor != 1)
            ||((state==1)&&(nextFloor>=1)&&(currentFloor<1)&& direction_1)
            ||((state==2)&&(nextFloor<=1)&&(currentFloor>1)&& !direction_1)) 
                ledOutside[1] <=1;  
            else begin end
        end
        else begin end

        // Check if the button on floor 2 is pressed
        if(floor_2_p) begin
            // check if the elevator is at floor 2 or moving towards floor 2 in the correct direction
            if(((state == 0)&& currentFloor != 2)
            ||((state==1)&&(nextFloor>=2)&&(currentFloor<2)&&direction_2)
            ||((state==2)&&(nextFloor<=2)&&(currentFloor>2)&& !direction_2)) 
                ledOutside[2] <=1;     
            else begin end  
        end   
        else begin end

        // Check if the button on floor 3 is pressed
        if(floor_3_p) begin
            // check if the elevator is at floor 3 or moving towards floor 3 in the correct direction
            if(((state == 0)&& currentFloor != 3)
            ||((state==1)&&(nextFloor>=3)&&(currentFloor<3)&& direction_3)
            ||((state==2)&&(nextFloor<=3)&&(currentFloor>3)&& !direction_3)) 
                ledOutside[3] <=1;
            else begin end       
        end   
        else begin end

        // Check if the button on floor 4 is pressed
        if(floor_4_p) begin
            // check if the elevator is at floor 4 or moving towards floor 4
            if(((state == 0)&& currentFloor != 4)
            ||((state==1)&&(nextFloor>=4)&&(currentFloor<4))
            ||((state==2)&&(nextFloor<=4)&&(currentFloor>4))) // redundant again
                ledOutside[4] <=1; 
            else begin end
        end
        else begin end
        
        // ------------------------------------------------------------------------------
        // BUTTONS RELEASED
        // ------------------------------------------------------------------------------
        // Check if the button on floor 0 is released
        if(floor_0_d && !buttonCheck[0]) begin
            // check if the elevator is at floor 0 or moving towards floor 0
            if((((state == 0)&& currentFloor != 0)
            ||((state==1)&&(nextFloor>=0)&&(currentFloor<0))
            ||((state==2)&&(nextFloor<=0)&&(currentFloor>0)))) begin
                ledInside[0] <=1;
                buttonCheck[0] <=1; 
            end
            else begin end
        end
        else begin end
        
        // Check if the button on floor 1 is released
        if(floor_1_d && !buttonCheck[1]) begin
            // check if the elevator is at floor 1 or moving towards floor 1
            if(((state == 0)&& currentFloor != 1)
            ||((state==1)&&(nextFloor>=1)&&(currentFloor<1))
            ||((state==2)&&(nextFloor<=1)&&(currentFloor>1))) begin
                ledInside[1] <=1;
                buttonCheck[1] <=1;           
            end
            else begin end
        end
        else begin end
        
        // Check if the button on floor 2 is released
        if(floor_2_d && !buttonCheck[2]) begin
            // check if the elevator is at floor 2 or moving towards floor 2
            if(((state == 0)&& currentFloor != 2)
            ||((state==1)&&(nextFloor>=2)&&(currentFloor<2))
            ||((state==2)&&(nextFloor<=2)&&(currentFloor>2))) begin
                ledInside[2] <=1;
                buttonCheck[2] <=1;            
            end
            else begin end
        end
        else begin end

        // Check if the button on floor 3 is released   
        if(floor_3_d && !buttonCheck[3]) begin
            // check if the elevator is at floor 3 or moving towards floor 3
            if(((state == 0)&& currentFloor != 3)
            ||((state==1)&&(nextFloor>=3)&&(currentFloor<3))
            ||((state==2)&&(nextFloor<=3)&&(currentFloor>3))) begin
                ledInside[3] <=1;
                buttonCheck[3] <=1;               
            end
            else begin end
        end  
        else begin end 
        
        // Check if the button on floor 4 is released
        if(floor_4_d && !buttonCheck[4]) begin
            // check if the elevator is at floor 4 or moving towards floor 4
            if(((state == 0)&& currentFloor != 4)
            ||((state==1)&&(nextFloor>=4)&&(currentFloor<4))
            ||((state==2)&&(nextFloor<=4)&&(currentFloor>4))) begin
                ledInside[4] <=1;
                buttonCheck[4] <=1; 
            end
            else begin end
        end
        else begin end      
        
        // ------------------------------------------------------------------------------
        // BUSY ELEVATOR CHECK
        // ------------------------------------------------------------------------------ 
        // Check if the elevator is busy and is currently at floor 0                  
        if(led_busy && currentFloor==0) begin
            // Turn off the inside and outside leds for floor 0
            ledInside[0] <= 0;
            ledOutside[0] <= 0;
        end
        // Check if the elevator is busy and is currently at floor 1
        else if(led_busy && currentFloor==1)begin
            // Turn off the inside and outside leds for floor 1
            ledInside[1] <= 0;
            ledOutside[1] <= 0;
        end
        // Check if the elevator is busy and is currently at floor 2
        else if(led_busy && currentFloor==2) begin
            // Turn off the inside and outside leds for floor 2
            ledInside[2] <= 0;
            ledOutside[2] <= 0;
        end   
        // Check if the elevator is busy and is currently at floor 3
        else if(led_busy && currentFloor==3) begin
            // Turn off the inside and outside leds for floor 3
            ledInside[3] <= 0;
            ledOutside[3] <= 0;
        end        
        // Check if the elevator is busy and is currently at floor 4      
        else if(led_busy && currentFloor==4) begin
            // Turn off the inside and outside leds for floor 4
            ledInside[4] <= 0;
            ledOutside[4] <= 0;
        end 
        else begin end               
    end
end

// ====================================================================================================
// Assign the next floor number to the signal "nextFloor" 
// based on the values of "clk_in", "rst", "state", "ledInside" and "ledOutside"

//[CONTINUE COMMENTING HERE]

always@(posedge clk_in or negedge rst)
begin
    if(!rst) begin
        nextFloor <= 0;
    end
    else begin
        case(state)
            0:
            begin
                if(ledInside[0]||ledOutside[0])
                    nextFloor<=0;
                else if(ledInside[1]||ledOutside[1])
                    nextFloor<=1;
                else if(ledInside[2]||ledOutside[2])
                    nextFloor<=2;
                else if(ledInside[3]||ledOutside[3])
                    nextFloor<=3;
                else if(ledInside[4]||ledOutside[4])
                    nextFloor<=4;
                else begin end
            end

            1:
            begin
                if(ledInside[0]||ledOutside[0])
                    nextFloor<=0;
                else if(ledInside[1]||ledOutside[1])
                    nextFloor<=1;
                else if(ledInside[2]||ledOutside[2])
                    nextFloor<=2;
                else if(ledInside[3]||ledOutside[3])
                    nextFloor<=3;
                else if(ledInside[4]||ledOutside[4])
                    nextFloor<=4;
                else begin end
            end
            
            2:
            begin
                if(ledInside[0]||ledOutside[0])
                    nextFloor<=0;
                else if(ledInside[1]||ledOutside[1])
                    nextFloor<=1;
                else if(ledInside[2]||ledOutside[2])
                    nextFloor<=2;
                else if(ledInside[3]||ledOutside[3])
                    nextFloor<=3;
                else if(ledInside[4]||ledOutside[4])
                    nextFloor<=4;
                else begin end
            end
        endcase
    end
end

always@(posedge clk_in or negedge rst)
begin
    if(!rst) begin
        {led_inside_4, led_inside_3, led_inside_2, led_inside_1 ,led_inside_0 } <= 0;
        {led_outside_4, led_outside_3 ,  led_outside_2, led_outside_1 ,led_outside_0} <= 0;
    end
    else begin
        {led_inside_4, led_inside_3, led_inside_2, led_inside_1, led_inside_0 } <= ledInside;
        {led_outside_4, led_outside_3, led_outside_2, led_outside_1, led_outside_0 } <= ledOutside;
    end
end


always @(posedge clk_in or negedge rst)
 begin
	if(!rst) begin
		a <= 8'b11110110;
        b <= 8'b11001110;
        c <= 8'b11001110;
        d <= 8'b11101010;
        e <= 8'b11100010;
        f <= 8'b11110010;
        g <= 8'b00100101;
        p <= 8'b11111111;

	end
	else begin
		if(currentFloor == 0) begin
			a[0] <= 0;
			b[0] <= 0;
			c[0] <= 0;
			d[0] <= 0;
			e[0] <= 0;
			f[0] <= 0;
			g[0] <= 1;
			p[0] <= 1;
		end
		
		else if(currentFloor == 1) begin
			a[0] <= 1;
			b[0] <= 0;
			c[0] <= 0;
			d[0] <= 1;
			e[0] <= 1;
			f[0] <= 1;
			g[0] <= 1;
			p[0] <= 1;
		end
		
		else if(currentFloor == 2) begin
			a[0] <= 0;
			b[0] <= 0;
			c[0] <= 1;
			d[0] <= 0;
			e[0] <= 0;
			f[0] <= 1;	
			g[0] <= 0;
			p[0] <= 1;
		end
		
		else if(currentFloor == 3) begin
			a[0] <= 0;
			b[0] <= 0;
			c[0] <= 0;
			d[0] <= 0;
			e[0] <= 1;
			f[0] <= 1;
			g[0] <= 0;
			p[0] <= 1;
		end
		
		else begin
		    a[0] <= 1;
		    b[0] <= 0;
		    c[0] <= 0;
		    d[0] <= 1;
		    e[0] <= 1;
		    f[0] <= 0;
		    g[0] <= 0;
		    p[0] <= 1;
		end
		
		if(state == 0) begin
            a[7:4] <= 4'b1111;
            b[7:4] <= 4'b1100;
            c[7:4] <= 4'b1100;
            d[7:4] <= 4'b1110;
            e[7:4] <= 4'b1110;
            f[7:4] <= 4'b1111;
            g[7:4] <= 4'b0010;
            p[7:4] <= 4'b1111;
         end
         
         else if(state == 1) begin
            a[5] <= 1;
            b[5] <= 0;
            c[5] <= 0;
            d[5] <= 0;
            e[5] <= 0;
            f[5] <= 0;
            g[5] <= 1;
            p[5] <= 1;
                                
            a[4] <= 0;
            b[4] <= 0;
            c[4] <= 1;
            d[4] <= 1;
            e[4] <= 0;
            f[4] <= 0;
            g[4] <= 0;
            p[4] <= 1;
         end
         
         else begin
            a[5] <= 1;
            b[5] <= 0;
            c[5] <= 0;
            d[5] <= 0;
            e[5] <= 0;
            f[5] <= 1;
            g[5] <= 0;
            p[5] <= 1;
                                                    
            a[4] <= 0;
            b[4] <= 0;
            c[4] <= 0;
            d[4] <= 0;
            e[4] <= 0;
            f[4] <= 0;
            g[4] <= 1;
            p[4] <= 1;            
        end
	end
 end
 
endmodule