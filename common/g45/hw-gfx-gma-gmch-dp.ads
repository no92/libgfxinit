--
-- Copyright (C) 2016 secunet Security Networks AG
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--

package HW.GFX.GMA.GMCH.DP
is

   procedure On
     (Port_Cfg : in     Port_Config;
      Pipe     : in     Pipe_Index;
      Success  :    out Boolean)
   with
      Pre => Port_Cfg.Port in GMCH_DP_Port;

   pragma Warnings (GNATprove, Off, "unused variable ""Pipe""",
                    Reason => "Needed for a common interface");
   procedure Off (Pipe : Pipe_Index; Port : GMCH_DP_Port);
   pragma Warnings (GNATprove, On, "unused variable ""Pipe""");
   procedure All_Off;

end HW.GFX.GMA.GMCH.DP;
