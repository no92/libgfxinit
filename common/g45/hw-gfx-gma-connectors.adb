--
-- Copyright (C) 2015-2016 secunet Security Networks AG
-- Copyright (C) 2016 Nico Huber <nico.h@gmx.de>
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

with HW.GFX.GMA.Config;
with HW.GFX.GMA.Panel;
with HW.GFX.GMA.GMCH.VGA;
with HW.GFX.GMA.GMCH.LVDS;
with HW.GFX.GMA.GMCH.HDMI;
with HW.GFX.GMA.GMCH.DP;

with HW.Debug;
with GNAT.Source_Info;

package body HW.GFX.GMA.Connectors
is

   procedure Post_Reset_Off is null;
   procedure Initialize is null;

   ----------------------------------------------------------------------------

   procedure Pre_On
     (Pipe        : in     Pipe_Index;
      Port_Cfg    : in     Port_Config;
      PLL_Hint    : in     Word32;
      Success     :    out Boolean)
   is
   begin
      pragma Debug (Debug.Put_Line (GNAT.Source_Info.Enclosing_Entity));
      Success := True;
   end Pre_On;

   procedure Post_On
     (Pipe     : in     Pipe_Index;
      Port_Cfg : in     Port_Config;
      PLL_Hint : in     Word32;
      Success  :    out Boolean)
   is
   begin
      pragma Debug (Debug.Put_Line (GNAT.Source_Info.Enclosing_Entity));
      Success := True;
      if Port_Cfg.Port = LVDS then
         GMCH.LVDS.On (Port_Cfg, Pipe);
      elsif Port_Cfg.Port = VGA then
         GMCH.VGA.On (Pipe, Port_Cfg.Mode);
      elsif Port_Cfg.Port in Digital_Port then
         if Port_Cfg.Display = DP and Port_Cfg.Port in GMCH_DP_Port then
            GMCH.DP.On (Port_Cfg, Pipe, Success);
         elsif Port_Cfg.Display = HDMI and Port_Cfg.Port in GMCH_HDMI_Port then
            GMCH.HDMI.On (Port_Cfg, Pipe);
         end if;
      end if;

      Panel.On (Port_Cfg.Panel, Wait => False);
      Panel.Backlight_On (Port_Cfg.Panel);
   end Post_On;

   ----------------------------------------------------------------------------

   procedure Pre_Off (Port_Cfg : Port_Config)
   is
   begin
      pragma Debug (Debug.Put_Line (GNAT.Source_Info.Enclosing_Entity));

      Panel.Backlight_Off (Port_Cfg.Panel);
      Panel.Off (Port_Cfg.Panel);
   end Pre_Off;

   procedure Post_Off (Port_Cfg : Port_Config)
   is
   begin
      pragma Debug (Debug.Put_Line (GNAT.Source_Info.Enclosing_Entity));
      if Port_Cfg.Port = LVDS then
         GMCH.LVDS.Off;
      elsif Port_Cfg.Port = VGA then
         GMCH.VGA.Off;
      elsif Port_Cfg.Display = DP and Port_Cfg.Port in GMCH_DP_Port then
         GMCH.DP.Off (Pipe_Index'First, -- unused
                      Port_Cfg.Port);
      elsif Port_Cfg.Display = HDMI and Port_Cfg.Port in GMCH_HDMI_Port then
         GMCH.HDMI.Off (Port_Cfg.Port);
      end if;
   end Post_Off;

   ----------------------------------------------------------------------------

   procedure Pre_All_Off
   is
   begin
      pragma Debug (Debug.Put_Line (GNAT.Source_Info.Enclosing_Entity));

      for P in Valid_Panels loop
         Panel.Backlight_Off (P);
         Panel.Off (P);
      end loop;
   end Pre_All_Off;

   procedure Post_All_Off
   is
   begin
      pragma Debug (Debug.Put_Line (GNAT.Source_Info.Enclosing_Entity));
      GMCH.LVDS.Off;
      GMCH.VGA.Off;
      GMCH.DP.All_Off;
      GMCH.HDMI.All_Off;
   end Post_All_Off;

end HW.GFX.GMA.Connectors;
