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

package HW.GFX.GMA.PCH.HDMI
is
   subtype IRL_PCH_HDMI_Port is PCH_HDMI_Port range PCH_HDMI_B .. PCH_HDMI_D;

   procedure On (Port_Cfg : Port_Config; FDI_Port : FDI_Port_Type)
   with
      Pre => Port_Cfg.PCH_Port in IRL_PCH_HDMI_Port;

   procedure Off (Port : IRL_PCH_HDMI_Port);
   procedure All_Off;

end HW.GFX.GMA.PCH.HDMI;
