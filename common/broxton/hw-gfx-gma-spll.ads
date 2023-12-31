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

private package HW.GFX.GMA.SPLL is

   -- Just for a common interface with Haswell's DDI.
   -- There is no SPLL (no FDI) on Broxton.

   procedure On is null;

   procedure Off is null;

end HW.GFX.GMA.SPLL;
