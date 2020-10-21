--
-- Copyright (C) 2015-2017 secunet Security Networks AG
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

with System;
with HW.GFX.GMA;
with HW.GFX.GMA.Config;

private package HW.GFX.GMA.Registers
with
   Abstract_State =>
    ((Address_State  with Part_Of => GMA.State),
     (Register_State with External, Part_Of => GMA.Device_State),
     (GTT_State      with External, Part_Of => GMA.Device_State)),
   Initializes => Address_State
is

   MMIO_GTT_32_Size     : constant := 16#20_0000#;
   MMIO_GTT_32_Offset   : constant := 16#20_0000#;

   -- Limit Broadwell+ to 4MiB to have a stable
   -- interface (i.e. same number of entries):
   MMIO_GTT_64_Size     : constant := 16#40_0000#;
   MMIO_GTT_64_Offset   : constant := 16#80_0000#;

   type Registers_Invalid_Index is
     (Invalid_Register, -- Allow a placeholder when access is not acceptable

      RCS_RING_BUFFER_TAIL,
      RCS_RING_BUFFER_HEAD,
      RCS_RING_BUFFER_STRT,
      RCS_RING_BUFFER_CTL,
      QUIRK_02084,
      QUIRK_02090,
      HWSTAM,
      MI_MODE,
      INSTPM,
      GT_MODE,
      CACHE_MODE_0,
      CTX_SIZE,
      PP_DCLV_HIGH,
      PP_DCLV_LOW,
      GFX_MODE,
      ARB_MODE,
      HWS_PGA,
      GAM_ECOCHK,
      GMCH_GMBUS0,
      GMCH_GMBUS1,
      GMCH_GMBUS2,
      GMCH_GMBUS3,
      GMCH_GMBUS4,
      GMCH_GMBUS5,
      GMCH_DPLL_A,
      GMCH_DPLL_B,
      GMCH_FPA0,
      GMCH_FPA1,
      GMCH_FPB0,
      GMCH_FPB1,
      MBCTL,
      UCGCTL1,
      UCGCTL2,
      GMCH_CLKCFG,
      GMCH_HPLLVCO_MOBILE,
      GMCH_HPLLVCO,
      VCS_RING_BUFFER_TAIL,
      VCS_RING_BUFFER_HEAD,
      VCS_RING_BUFFER_STRT,
      VCS_RING_BUFFER_CTL,
      SLEEP_PSMI_CONTROL,
      VCS_HWSTAM,
      VCS_PP_DCLV_HIGH,
      VCS_PP_DCLV_LOW,
      GAC_ECO_BITS,
      BCS_RING_BUFFER_TAIL,
      BCS_RING_BUFFER_HEAD,
      BCS_RING_BUFFER_STRT,
      BCS_RING_BUFFER_CTL,
      BCS_HWSTAM,
      BCS_PP_DCLV_HIGH,
      BCS_PP_DCLV_LOW,
      GAB_CTL_REG,
      CPU_VGACNTRL,
      FUSE_STATUS,
      ILK_DISPLAY_CHICKEN2,
      FUSE_STRAP,
      DSPCLK_GATE_D,
      FBA_CFB_BASE,
      FBC_CTL,
      IPS_CTL,
      DEISR,
      DEIMR,
      DEIIR,
      DEIER,
      GTISR,
      GTIMR,
      GTIIR,
      GTIER,
      IIR,
      HOTPLUG_CTL,
      ARB_CTL,
      DBUF_CTL,
      WM_PIPE_A,
      WM_PIPE_B,
      WM1_LP_ILK,
      WM2_LP_ILK,
      WM3_LP_ILK,
      WM_PIPE_C,
      WM_LINETIME_A,
      WM_LINETIME_B,
      WM_LINETIME_C,
      PWR_WELL_CTL_BIOS,
      PWR_WELL_CTL_DRIVER,
      PWR_WELL_CTL_KVMR,
      PWR_WELL_CTL_DEBUG,
      PWR_WELL_CTL5,
      PWR_WELL_CTL6,
      CDCLK_CTL,
      LCPLL1_CTL,
      LCPLL2_CTL,
      SPLL_CTL,
      WRPLL_CTL_1,
      WRPLL_CTL_2,
      BXT_DE_PLL_ENABLE,
      BXT_PORT_PLL_ENABLE_A,
      BXT_PORT_PLL_ENABLE_B,
      BXT_PORT_PLL_ENABLE_C,
      PORT_CLK_SEL_DDIA,
      PORT_CLK_SEL_DDIB,
      PORT_CLK_SEL_DDIC,
      PORT_CLK_SEL_DDID,
      PORT_CLK_SEL_DDIE,
      TRANSA_CLK_SEL,
      TRANSB_CLK_SEL,
      TRANSC_CLK_SEL,
      CDCLK_FREQ,
      NDE_RSTWRN_OPT,
      GEN8_CHICKEN_DCPR_1,
      BLC_PWM_CPU_CTL2,
      BLC_PWM_CPU_CTL,
      DFSM,
      HTOTAL_A,
      HBLANK_A,
      HSYNC_A,
      VTOTAL_A,
      VBLANK_A,
      VSYNC_A,
      PIPEASRC,
      PIPE_VSYNCSHIFT_A,
      PIPEA_DATA_M1,
      PIPEA_DATA_N1,
      PIPEA_LINK_M1,
      PIPEA_LINK_N1,
      FDI_TX_CTL_A,
      PIPEA_DDI_FUNC_CTL,
      PIPEA_MSA_MISC,
      SRD_CTL_A,
      SRD_STATUS_A,
      HTOTAL_B,
      HBLANK_B,
      HSYNC_B,
      VTOTAL_B,
      VBLANK_B,
      VSYNC_B,
      PIPEBSRC,
      PIPE_VSYNCSHIFT_B,
      PIPEB_DATA_M1,
      PIPEB_DATA_N1,
      PIPEB_LINK_M1,
      PIPEB_LINK_N1,
      FDI_TX_CTL_B,
      PORT_HOTPLUG_EN,
      PORT_HOTPLUG_STAT,
      GMCH_SDVOB,
      GMCH_SDVOC,
      GMCH_LVDS,
      GMCH_PP_STATUS,
      GMCH_PP_CONTROL,
      GMCH_PP_ON_DELAYS,
      GMCH_PP_OFF_DELAYS,
      GMCH_PP_DIVISOR,
      GMCH_PFIT_CONTROL,
      PIPEB_DDI_FUNC_CTL,
      PIPEB_MSA_MISC,
      SRD_CTL_B,
      SRD_STATUS_B,
      HTOTAL_C,
      HBLANK_C,
      HSYNC_C,
      VTOTAL_C,
      VBLANK_C,
      VSYNC_C,
      PIPECSRC,
      G4X_AUD_VID_DID,
      PIPE_VSYNCSHIFT_C,
      PIPEC_DATA_M1,
      PIPEC_DATA_N1,
      PIPEC_LINK_M1,
      PIPEC_LINK_N1,
      FDI_TX_CTL_C,
      PIPEC_DDI_FUNC_CTL,
      PIPEC_MSA_MISC,
      SRD_CTL_C,
      SRD_STATUS_C,
      DDI_BUF_CTL_A,
      DDI_AUX_CTL_A,
      DDI_AUX_DATA_A_1,
      DDI_AUX_DATA_A_2,
      DDI_AUX_DATA_A_3,
      DDI_AUX_DATA_A_4,
      DDI_AUX_DATA_A_5,
      DDI_AUX_MUTEX_A,
      DP_TP_CTL_A,
      DDI_BUF_CTL_B,
      DDI_AUX_CTL_B,
      DDI_AUX_DATA_B_1,
      DDI_AUX_DATA_B_2,
      DDI_AUX_DATA_B_3,
      DDI_AUX_DATA_B_4,
      DDI_AUX_DATA_B_5,
      DDI_AUX_MUTEX_B,
      DP_TP_CTL_B,
      DP_TP_STATUS_B,
      DDI_BUF_CTL_C,
      DDI_AUX_CTL_C,
      DDI_AUX_DATA_C_1,
      DDI_AUX_DATA_C_2,
      DDI_AUX_DATA_C_3,
      DDI_AUX_DATA_C_4,
      DDI_AUX_DATA_C_5,
      DDI_AUX_MUTEX_C,
      DP_TP_CTL_C,
      DP_TP_STATUS_C,
      DDI_BUF_CTL_D,
      DDI_AUX_CTL_D,
      DDI_AUX_DATA_D_1,
      DDI_AUX_DATA_D_2,
      DDI_AUX_DATA_D_3,
      DDI_AUX_DATA_D_4,
      DDI_AUX_DATA_D_5,
      DDI_AUX_MUTEX_D,
      DP_TP_CTL_D,
      DP_TP_STATUS_D,
      DDI_BUF_CTL_E,
      DP_TP_CTL_E,
      DP_TP_STATUS_E,
      SRD_CTL,
      SRD_STATUS,
      BXT_PHY_CTL_A,
      BXT_PHY_CTL_B,
      BXT_PHY_CTL_C,
      BXT_PHY_CTL_FAM_EDP,
      BXT_PHY_CTL_FAM_DDI,
      DDI_BUF_TRANS_A_S0T1,
      DDI_BUF_TRANS_A_S0T2,
      DDI_BUF_TRANS_A_S1T1,
      DDI_BUF_TRANS_A_S1T2,
      DDI_BUF_TRANS_A_S2T1,
      DDI_BUF_TRANS_A_S2T2,
      DDI_BUF_TRANS_A_S3T1,
      DDI_BUF_TRANS_A_S3T2,
      DDI_BUF_TRANS_A_S4T1,
      DDI_BUF_TRANS_A_S4T2,
      DDI_BUF_TRANS_A_S5T1,
      DDI_BUF_TRANS_A_S5T2,
      DDI_BUF_TRANS_A_S6T1,
      DDI_BUF_TRANS_A_S6T2,
      DDI_BUF_TRANS_A_S7T1,
      DDI_BUF_TRANS_A_S7T2,
      DDI_BUF_TRANS_A_S8T1,
      DDI_BUF_TRANS_A_S8T2,
      DDI_BUF_TRANS_A_S9T1,
      DDI_BUF_TRANS_A_S9T2,
      DDI_BUF_TRANS_B_S0T1,
      DDI_BUF_TRANS_B_S0T2,
      DDI_BUF_TRANS_B_S1T1,
      DDI_BUF_TRANS_B_S1T2,
      DDI_BUF_TRANS_B_S2T1,
      DDI_BUF_TRANS_B_S2T2,
      DDI_BUF_TRANS_B_S3T1,
      DDI_BUF_TRANS_B_S3T2,
      DDI_BUF_TRANS_B_S4T1,
      DDI_BUF_TRANS_B_S4T2,
      DDI_BUF_TRANS_B_S5T1,
      DDI_BUF_TRANS_B_S5T2,
      DDI_BUF_TRANS_B_S6T1,
      DDI_BUF_TRANS_B_S6T2,
      DDI_BUF_TRANS_B_S7T1,
      DDI_BUF_TRANS_B_S7T2,
      DDI_BUF_TRANS_B_S8T1,
      DDI_BUF_TRANS_B_S8T2,
      DDI_BUF_TRANS_B_S9T1,
      DDI_BUF_TRANS_B_S9T2,
      DDI_BUF_TRANS_C_S0T1,
      DDI_BUF_TRANS_C_S0T2,
      DDI_BUF_TRANS_C_S1T1,
      DDI_BUF_TRANS_C_S1T2,
      DDI_BUF_TRANS_C_S2T1,
      DDI_BUF_TRANS_C_S2T2,
      DDI_BUF_TRANS_C_S3T1,
      DDI_BUF_TRANS_C_S3T2,
      DDI_BUF_TRANS_C_S4T1,
      DDI_BUF_TRANS_C_S4T2,
      DDI_BUF_TRANS_C_S5T1,
      DDI_BUF_TRANS_C_S5T2,
      DDI_BUF_TRANS_C_S6T1,
      DDI_BUF_TRANS_C_S6T2,
      DDI_BUF_TRANS_C_S7T1,
      DDI_BUF_TRANS_C_S7T2,
      DDI_BUF_TRANS_C_S8T1,
      DDI_BUF_TRANS_C_S8T2,
      DDI_BUF_TRANS_C_S9T1,
      DDI_BUF_TRANS_C_S9T2,
      DDI_BUF_TRANS_D_S0T1,
      DDI_BUF_TRANS_D_S0T2,
      DDI_BUF_TRANS_D_S1T1,
      DDI_BUF_TRANS_D_S1T2,
      DDI_BUF_TRANS_D_S2T1,
      DDI_BUF_TRANS_D_S2T2,
      DDI_BUF_TRANS_D_S3T1,
      DDI_BUF_TRANS_D_S3T2,
      DDI_BUF_TRANS_D_S4T1,
      DDI_BUF_TRANS_D_S4T2,
      DDI_BUF_TRANS_D_S5T1,
      DDI_BUF_TRANS_D_S5T2,
      DDI_BUF_TRANS_D_S6T1,
      DDI_BUF_TRANS_D_S6T2,
      DDI_BUF_TRANS_D_S7T1,
      DDI_BUF_TRANS_D_S7T2,
      DDI_BUF_TRANS_D_S8T1,
      DDI_BUF_TRANS_D_S8T2,
      DDI_BUF_TRANS_D_S9T1,
      DDI_BUF_TRANS_D_S9T2,
      DDI_BUF_TRANS_E_S0T1,
      DDI_BUF_TRANS_E_S0T2,
      DDI_BUF_TRANS_E_S1T1,
      DDI_BUF_TRANS_E_S1T2,
      DDI_BUF_TRANS_E_S2T1,
      DDI_BUF_TRANS_E_S2T2,
      DDI_BUF_TRANS_E_S3T1,
      DDI_BUF_TRANS_E_S3T2,
      DDI_BUF_TRANS_E_S4T1,
      DDI_BUF_TRANS_E_S4T2,
      DDI_BUF_TRANS_E_S5T1,
      DDI_BUF_TRANS_E_S5T2,
      DDI_BUF_TRANS_E_S6T1,
      DDI_BUF_TRANS_E_S6T2,
      DDI_BUF_TRANS_E_S7T1,
      DDI_BUF_TRANS_E_S7T2,
      DDI_BUF_TRANS_E_S8T1,
      DDI_BUF_TRANS_E_S8T2,
      DDI_BUF_TRANS_E_S9T1,
      DDI_BUF_TRANS_E_S9T2,
      AUD_VID_DID,
      PFA_WIN_POS,
      PFA_WIN_SZ,
      PFA_CTL_1,
      PS_WIN_POS_1_A,
      PS_WIN_SZ_1_A,
      PS_CTRL_1_A,
      PS_WIN_POS_2_A,
      PS_WIN_SZ_2_A,
      PS_CTRL_2_A,
      PFB_WIN_POS,
      PFB_WIN_SZ,
      PFB_CTL_1,
      PS_WIN_POS_1_B,
      PS_WIN_SZ_1_B,
      PS_CTRL_1_B,
      PS_WIN_POS_2_B,
      PS_WIN_SZ_2_B,
      PS_CTRL_2_B,
      PFC_WIN_POS,
      PFC_WIN_SZ,
      PFC_CTL_1,
      PS_WIN_POS_1_C,
      PS_WIN_SZ_1_C,
      PS_CTRL_1_C,
      BXT_PORT_CL1CM_DW0_BC,
      DISPIO_CR_TX_BMU_CR0,
      BXT_PORT_CL1CM_DW9_BC,
      BXT_PORT_CL1CM_DW10_BC,
      BXT_PORT_PLL_EBB_0_B,
      BXT_PORT_PLL_EBB_4_B,
      DPLL1_CFGR1,
      DPLL1_CFGR2,
      DPLL2_CFGR1,
      DPLL2_CFGR2,
      DPLL3_CFGR1,
      DPLL3_CFGR2,
      DPLL_CTRL1,
      DPLL_CTRL2,
      DPLL_STATUS,
      BXT_PORT_CL1CM_DW28_BC,
      BXT_PORT_CL1CM_DW30_BC,
      BXT_PORT_PLL_0_B,
      BXT_PORT_PLL_1_B,
      BXT_PORT_PLL_2_B,
      BXT_PORT_PLL_3_B,
      BXT_PORT_PLL_6_B,
      BXT_PORT_PLL_8_B,
      BXT_PORT_PLL_9_B,
      BXT_PORT_PLL_10_B,
      BXT_PORT_REF_DW3_BC,
      BXT_PORT_REF_DW6_BC,
      BXT_PORT_REF_DW8_BC,
      BXT_PORT_PLL_EBB_0_C,
      BXT_PORT_PLL_EBB_4_C,
      BXT_PORT_CL2CM_DW6_BC,
      BXT_PORT_PLL_0_C,
      BXT_PORT_PLL_1_C,
      BXT_PORT_PLL_2_C,
      BXT_PORT_PLL_3_C,
      BXT_PORT_PLL_6_C,
      BXT_PORT_PLL_8_C,
      BXT_PORT_PLL_9_C,
      BXT_PORT_PLL_10_C,
      BXT_PORT_PCS_DW10_01_B,
      BXT_PORT_PCS_DW12_01_B,
      BXT_PORT_TX_DW2_LN0_B,
      BXT_PORT_TX_DW3_LN0_B,
      BXT_PORT_TX_DW4_LN0_B,
      BXT_PORT_TX_DW14_LN0_B,
      BXT_PORT_TX_DW14_LN1_B,
      BXT_PORT_TX_DW14_LN2_B,
      BXT_PORT_TX_DW14_LN3_B,
      BXT_PORT_PCS_DW10_01_C,
      BXT_PORT_PCS_DW12_01_C,
      BXT_PORT_TX_DW2_LN0_C,
      BXT_PORT_TX_DW3_LN0_C,
      BXT_PORT_TX_DW4_LN0_C,
      BXT_PORT_TX_DW14_LN0_C,
      BXT_PORT_TX_DW14_LN1_C,
      BXT_PORT_TX_DW14_LN2_C,
      BXT_PORT_TX_DW14_LN3_C,
      BXT_PORT_PCS_DW10_GRP_B,
      BXT_PORT_PCS_DW12_GRP_B,
      BXT_PORT_TX_DW2_GRP_B,
      BXT_PORT_TX_DW3_GRP_B,
      BXT_PORT_TX_DW4_GRP_B,
      BXT_PORT_PCS_DW10_GRP_C,
      BXT_PORT_PCS_DW12_GRP_C,
      BXT_PORT_TX_DW2_GRP_C,
      BXT_PORT_TX_DW3_GRP_C,
      BXT_PORT_TX_DW4_GRP_C,
      BXT_DE_PLL_CTL,
      HTOTAL_EDP,
      HBLANK_EDP,
      HSYNC_EDP,
      VTOTAL_EDP,
      VBLANK_EDP,
      VSYNC_EDP,
      PIPE_EDP_DATA_M1,
      PIPE_EDP_DATA_N1,
      PIPE_EDP_LINK_M1,
      PIPE_EDP_LINK_N1,
      PIPE_EDP_DDI_FUNC_CTL,
      PIPE_EDP_MSA_MISC,
      SRD_CTL_EDP,
      SRD_STATUS_EDP,
      PIPE_SCANLINE_A,
      PIPEACONF,
      PIPEAMISC,
      PIPE_FRMCNT_A,
      PIPEA_GMCH_DATA_M,
      PIPEA_GMCH_DATA_N,
      PIPEA_GMCH_LINK_M,
      PIPEA_GMCH_LINK_N,
      CUR_CTL_A,
      CUR_BASE_A,
      CUR_POS_A,
      CUR_FBC_CTL_A,
      CURBCNTR,
      CURBBASE,
      CURBPOS,
      CUR_WM_A_0,
      CUR_WM_A_1,
      CUR_WM_A_2,
      CUR_WM_A_3,
      CUR_WM_A_4,
      CUR_WM_A_5,
      CUR_WM_A_6,
      CUR_WM_A_7,
      CUR_BUF_CFG_A,
      DSPACNTR,
      DSPALINOFF,
      DSPASTRIDE,
      PLANE_POS_1_A,
      PLANE_SIZE_1_A,
      DSPASURF,
      DSPATILEOFF,
      PLANE_WM_1_A_0,
      PLANE_WM_1_A_1,
      PLANE_WM_1_A_2,
      PLANE_WM_1_A_3,
      PLANE_WM_1_A_4,
      PLANE_WM_1_A_5,
      PLANE_WM_1_A_6,
      PLANE_WM_1_A_7,
      PLANE_BUF_CFG_1_A,
      SPACNTR,
      PIPE_SCANLINE_B,
      PIPEBCONF,
      PIPEBMISC,
      PIPE_FRMCNT_B,
      PIPEB_GMCH_DATA_M,
      PIPEB_GMCH_DATA_N,
      PIPEB_GMCH_LINK_M,
      PIPEB_GMCH_LINK_N,
      CUR_CTL_B,
      CUR_BASE_B,
      CUR_POS_B,
      CUR_FBC_CTL_B,
      CUR_WM_B_0,
      CUR_WM_B_1,
      CUR_WM_B_2,
      CUR_WM_B_3,
      CUR_WM_B_4,
      CUR_WM_B_5,
      CUR_WM_B_6,
      CUR_WM_B_7,
      CUR_BUF_CFG_B,
      DSPBCNTR,
      DSPBLINOFF,
      DSPBSTRIDE,
      PLANE_POS_1_B,
      PLANE_SIZE_1_B,
      DSPBSURF,
      DSPBTILEOFF,
      PLANE_WM_1_B_0,
      PLANE_WM_1_B_1,
      PLANE_WM_1_B_2,
      PLANE_WM_1_B_3,
      PLANE_WM_1_B_4,
      PLANE_WM_1_B_5,
      PLANE_WM_1_B_6,
      PLANE_WM_1_B_7,
      PLANE_BUF_CFG_1_B,
      SPBCNTR,
      GMCH_VGACNTRL,
      PIPE_SCANLINE_C,
      PIPECCONF,
      PIPECMISC,
      PIPE_FRMCNT_C,
      CUR_CTL_C,
      CUR_BASE_C,
      CUR_POS_C,
      CUR_FBC_CTL_C,
      CUR_WM_C_0,
      CUR_WM_C_1,
      CUR_WM_C_2,
      CUR_WM_C_3,
      CUR_WM_C_4,
      CUR_WM_C_5,
      CUR_WM_C_6,
      CUR_WM_C_7,
      CUR_BUF_CFG_C,
      DSPCCNTR,
      DSPCLINOFF,
      DSPCSTRIDE,
      PLANE_POS_1_C,
      PLANE_SIZE_1_C,
      DSPCSURF,
      DSPCTILEOFF,
      PLANE_WM_1_C_0,
      PLANE_WM_1_C_1,
      PLANE_WM_1_C_2,
      PLANE_WM_1_C_3,
      PLANE_WM_1_C_4,
      PLANE_WM_1_C_5,
      PLANE_WM_1_C_6,
      PLANE_WM_1_C_7,
      PLANE_BUF_CFG_1_C,
      SPCCNTR,
      PIPE_EDP_CONF,
      PCH_FDI_CHICKEN_B_C,
      QUIRK_C2004,
      SFUSE_STRAP,
      PCH_DSPCLK_GATE_D,
      SDEISR,
      SDEIMR,
      SDEIIR,
      SDEIER,
      SHOTPLUG_CTL,
      PCH_GMBUS0,
      PCH_GMBUS1,
      PCH_GMBUS2,
      PCH_GMBUS3,
      PCH_GMBUS4,
      PCH_GMBUS5,
      SBI_ADDR,
      SBI_DATA,
      SBI_CTL_STAT,
      PCH_DPLL_A,
      PCH_DPLL_B,
      PCH_PIXCLK_GATE,
      PCH_FPA0,
      PCH_FPA1,
      PCH_FPB0,
      PCH_FPB1,
      PCH_DREF_CONTROL,
      PCH_RAWCLK_FREQ,
      PCH_DPLL_SEL,
      PCH_PP_STATUS,
      PCH_PP_CONTROL,
      PCH_PP_ON_DELAYS,
      PCH_PP_OFF_DELAYS,
      PCH_PP_DIVISOR,
      BXT_PP_STATUS_2,
      BXT_PP_CONTROL_2,
      BXT_PP_ON_DELAYS_2,
      BXT_PP_OFF_DELAYS_2,
      BLC_PWM_PCH_CTL1,
      BLC_PWM_PCH_CTL2,
      BXT_BLC_PWM_DUTY_1,
      BXT_BLC_PWM_CTL_2,
      BXT_BLC_PWM_FREQ_2,
      BXT_BLC_PWM_DUTY_2,
      TRANS_HTOTAL_A,
      TRANS_HBLANK_A,
      TRANS_HSYNC_A,
      TRANS_VTOTAL_A,
      TRANS_VBLANK_A,
      TRANS_VSYNC_A,
      TRANS_VSYNCSHIFT_A,
      TRANSA_DATA_M1,
      TRANSA_DATA_N1,
      TRANSA_DP_LINK_M1,
      TRANSA_DP_LINK_N1,
      TRANS_DP_CTL_A,
      TRANS_HTOTAL_B,
      TRANS_HBLANK_B,
      TRANS_HSYNC_B,
      TRANS_VTOTAL_B,
      TRANS_VBLANK_B,
      TRANS_VSYNC_B,
      TRANS_VSYNCSHIFT_B,
      TRANSB_DATA_M1,
      TRANSB_DATA_N1,
      TRANSB_DP_LINK_M1,
      TRANSB_DP_LINK_N1,
      PCH_ADPA,
      PCH_HDMIB,
      PCH_HDMIC,
      PCH_HDMID,
      PCH_LVDS,
      TRANS_DP_CTL_B,
      TRANS_HTOTAL_C,
      TRANS_HBLANK_C,
      TRANS_HSYNC_C,
      TRANS_VTOTAL_C,
      TRANS_VBLANK_C,
      TRANS_VSYNC_C,
      TRANS_VSYNCSHIFT_C,
      TRANSC_DATA_M1,
      TRANSC_DATA_N1,
      TRANSC_DP_LINK_M1,
      TRANSC_DP_LINK_N1,
      TRANS_DP_CTL_C,
      PCH_DP_B,
      PCH_DP_AUX_CTL_B,
      PCH_DP_AUX_DATA_B_1,
      PCH_DP_AUX_DATA_B_2,
      PCH_DP_AUX_DATA_B_3,
      PCH_DP_AUX_DATA_B_4,
      PCH_DP_AUX_DATA_B_5,
      PCH_DP_C,
      PCH_DP_AUX_CTL_C,
      PCH_DP_AUX_DATA_C_1,
      PCH_DP_AUX_DATA_C_2,
      PCH_DP_AUX_DATA_C_3,
      PCH_DP_AUX_DATA_C_4,
      PCH_DP_AUX_DATA_C_5,
      PCH_DP_D,
      PCH_DP_AUX_CTL_D,
      PCH_DP_AUX_DATA_D_1,
      PCH_DP_AUX_DATA_D_2,
      PCH_DP_AUX_DATA_D_3,
      PCH_DP_AUX_DATA_D_4,
      PCH_DP_AUX_DATA_D_5,
      AUD_CONFIG_A,
      PCH_AUD_VID_DID,
      AUD_HDMIW_HDMIEDID_A,
      AUD_CNTL_ST_A,
      AUD_CNTRL_ST2,
      AUD_CONFIG_B,
      AUD_HDMIW_HDMIEDID_B,
      AUD_CNTL_ST_B,
      AUD_CONFIG_C,
      AUD_HDMIW_HDMIEDID_C,
      AUD_CNTL_ST_C,
      TRANSACONF,
      FDI_RXA_CTL,
      FDI_RX_MISC_A,
      FDI_RXA_IIR,
      FDI_RXA_IMR,
      FDI_RXA_TUSIZE1,
      QUIRK_F0060,
      TRANSA_CHICKEN2,
      TRANSBCONF,
      FDI_RXB_CTL,
      FDI_RX_MISC_B,
      FDI_RXB_IIR,
      FDI_RXB_IMR,
      FDI_RXB_TUSIZE1,
      QUIRK_F1060,
      TRANSB_CHICKEN2,
      TRANSCCONF,
      FDI_RXC_CTL,
      FDI_RX_MISC_C,
      FDI_RXC_IIR,
      FDI_RXC_IMR,
      FDI_RXC_TUSIZE1,
      QUIRK_F2060,
      TRANSC_CHICKEN2,
      LCPLL_CTL,
      BXT_P_CR_GT_DISP_PWRON,
      GT_MAILBOX,
      GT_MAILBOX_DATA,
      GT_MAILBOX_DATA_1,
      BXT_PORT_CL1CM_DW0_A,
      BXT_PORT_CL1CM_DW9_A,
      BXT_PORT_CL1CM_DW10_A,
      BXT_PORT_PLL_EBB_0_A,
      BXT_PORT_PLL_EBB_4_A,
      BXT_PORT_CL1CM_DW28_A,
      BXT_PORT_CL1CM_DW30_A,
      BXT_PORT_PLL_0_A,
      BXT_PORT_PLL_1_A,
      BXT_PORT_PLL_2_A,
      BXT_PORT_PLL_3_A,
      BXT_PORT_PLL_6_A,
      BXT_PORT_PLL_8_A,
      BXT_PORT_PLL_9_A,
      BXT_PORT_PLL_10_A,
      BXT_PORT_REF_DW3_A,
      BXT_PORT_REF_DW6_A,
      BXT_PORT_REF_DW8_A,
      BXT_PORT_PCS_DW10_01_A,
      BXT_PORT_PCS_DW12_01_A,
      BXT_PORT_TX_DW2_LN0_A,
      BXT_PORT_TX_DW3_LN0_A,
      BXT_PORT_TX_DW4_LN0_A,
      BXT_PORT_TX_DW14_LN0_A,
      BXT_PORT_TX_DW14_LN1_A,
      BXT_PORT_TX_DW14_LN2_A,
      BXT_PORT_TX_DW14_LN3_A,
      BXT_PORT_PCS_DW10_GRP_A,
      BXT_PORT_PCS_DW12_GRP_A,
      BXT_PORT_TX_DW2_GRP_A,
      BXT_PORT_TX_DW3_GRP_A,
      BXT_PORT_TX_DW4_GRP_A);

   pragma Warnings
     (GNATprove, Off, "pragma ""KEEP_NAMES"" ignored *(not yet supported)",
      Reason => "TODO: Should it matter?");
   pragma Keep_Names (Registers_Invalid_Index);
   pragma Warnings
     (GNATprove, On, "pragma ""KEEP_NAMES"" ignored *(not yet supported)");

   Register_Width : constant := 4;

   for Registers_Invalid_Index use
     (Invalid_Register     => 0,

   ---------------------------------------------------------------------------
   -- Pipe A registers
   ---------------------------------------------------------------------------

      -- pipe timing registers

      HTOTAL_A              => 16#06_0000# / Register_Width,
      HBLANK_A              => 16#06_0004# / Register_Width,
      HSYNC_A               => 16#06_0008# / Register_Width,
      VTOTAL_A              => 16#06_000c# / Register_Width,
      VBLANK_A              => 16#06_0010# / Register_Width,
      VSYNC_A               => 16#06_0014# / Register_Width,
      PIPEASRC              => 16#06_001c# / Register_Width,
      PIPEACONF             => 16#07_0008# / Register_Width,
      PIPEAMISC             => 16#07_0030# / Register_Width,
      TRANS_HTOTAL_A        => 16#0e_0000# / Register_Width,
      TRANS_HBLANK_A        => 16#0e_0004# / Register_Width,
      TRANS_HSYNC_A         => 16#0e_0008# / Register_Width,
      TRANS_VTOTAL_A        => 16#0e_000c# / Register_Width,
      TRANS_VBLANK_A        => 16#0e_0010# / Register_Width,
      TRANS_VSYNC_A         => 16#0e_0014# / Register_Width,
      TRANSA_DATA_M1        => 16#0e_0030# / Register_Width,
      TRANSA_DATA_N1        => 16#0e_0034# / Register_Width,
      TRANSA_DP_LINK_M1     => 16#0e_0040# / Register_Width,
      TRANSA_DP_LINK_N1     => 16#0e_0044# / Register_Width,
      PIPEA_DATA_M1         => 16#06_0030# / Register_Width,
      PIPEA_DATA_N1         => 16#06_0034# / Register_Width,
      PIPEA_LINK_M1         => 16#06_0040# / Register_Width,
      PIPEA_LINK_N1         => 16#06_0044# / Register_Width,
      PIPEA_GMCH_DATA_M     => 16#07_0050# / Register_Width,
      PIPEA_GMCH_DATA_N     => 16#07_0054# / Register_Width,
      PIPEA_GMCH_LINK_M     => 16#07_0060# / Register_Width,
      PIPEA_GMCH_LINK_N     => 16#07_0064# / Register_Width,
      PIPEA_DDI_FUNC_CTL    => 16#06_0400# / Register_Width,
      PIPEA_MSA_MISC        => 16#06_0410# / Register_Width,

      -- PCH sideband interface registers
      SBI_ADDR              => 16#0c_6000# / Register_Width,
      SBI_DATA              => 16#0c_6004# / Register_Width,
      SBI_CTL_STAT          => 16#0c_6008# / Register_Width,

      -- GMCH clock registers
      GMCH_DPLL_A           => 16#00_6014# / Register_Width,
      GMCH_FPA0             => 16#00_6040# / Register_Width,
      GMCH_FPA1             => 16#00_6044# / Register_Width,

      -- PCH clock registers
      PCH_DPLL_A            => 16#0c_6014# / Register_Width,
      PCH_PIXCLK_GATE       => 16#0c_6020# / Register_Width,
      PCH_FPA0              => 16#0c_6040# / Register_Width,
      PCH_FPA1              => 16#0c_6044# / Register_Width,

      -- panel fitter
      PFA_CTL_1             => 16#06_8080# / Register_Width,
      PFA_WIN_POS           => 16#06_8070# / Register_Width,
      PFA_WIN_SZ            => 16#06_8074# / Register_Width,
      PS_WIN_POS_1_A        => 16#06_8170# / Register_Width,
      PS_WIN_SZ_1_A         => 16#06_8174# / Register_Width,
      PS_CTRL_1_A           => 16#06_8180# / Register_Width,
      PS_WIN_POS_2_A        => 16#06_8270# / Register_Width,
      PS_WIN_SZ_2_A         => 16#06_8274# / Register_Width,
      PS_CTRL_2_A           => 16#06_8280# / Register_Width,

      -- cursor control
      CUR_CTL_A             => 16#07_0080# / Register_Width,
      CUR_BASE_A            => 16#07_0084# / Register_Width,
      CUR_POS_A             => 16#07_0088# / Register_Width,
      CUR_FBC_CTL_A         => 16#07_00a0# / Register_Width,

      -- display control
      DSPACNTR              => 16#07_0180# / Register_Width,
      DSPALINOFF            => 16#07_0184# / Register_Width,
      DSPASTRIDE            => 16#07_0188# / Register_Width,
      PLANE_POS_1_A         => 16#07_018c# / Register_Width,
      PLANE_SIZE_1_A        => 16#07_0190# / Register_Width,
      DSPASURF              => 16#07_019c# / Register_Width,
      DSPATILEOFF           => 16#07_01a4# / Register_Width,

      -- sprite control
      SPACNTR               => 16#07_0280# / Register_Width,

      -- FDI and PCH transcoder control
      FDI_TX_CTL_A          => 16#06_0100# / Register_Width,
      FDI_RXA_CTL           => 16#0f_000c# / Register_Width,
      FDI_RX_MISC_A         => 16#0f_0010# / Register_Width,
      FDI_RXA_IIR           => 16#0f_0014# / Register_Width,
      FDI_RXA_IMR           => 16#0f_0018# / Register_Width,
      FDI_RXA_TUSIZE1       => 16#0f_0030# / Register_Width,
      TRANSACONF            => 16#0f_0008# / Register_Width,
      TRANSA_CHICKEN2       => 16#0f_0064# / Register_Width,

      -- watermark registers
      WM_LINETIME_A         => 16#04_5270# / Register_Width,
      PLANE_WM_1_A_0        => 16#07_0240# / Register_Width,
      PLANE_WM_1_A_1        => 16#07_0244# / Register_Width,
      PLANE_WM_1_A_2        => 16#07_0248# / Register_Width,
      PLANE_WM_1_A_3        => 16#07_024c# / Register_Width,
      PLANE_WM_1_A_4        => 16#07_0250# / Register_Width,
      PLANE_WM_1_A_5        => 16#07_0254# / Register_Width,
      PLANE_WM_1_A_6        => 16#07_0258# / Register_Width,
      PLANE_WM_1_A_7        => 16#07_025c# / Register_Width,
      PLANE_BUF_CFG_1_A     => 16#07_027c# / Register_Width,
      CUR_WM_A_0            => 16#07_0140# / Register_Width,
      CUR_WM_A_1            => 16#07_0144# / Register_Width,
      CUR_WM_A_2            => 16#07_0148# / Register_Width,
      CUR_WM_A_3            => 16#07_014c# / Register_Width,
      CUR_WM_A_4            => 16#07_0150# / Register_Width,
      CUR_WM_A_5            => 16#07_0154# / Register_Width,
      CUR_WM_A_6            => 16#07_0158# / Register_Width,
      CUR_WM_A_7            => 16#07_015c# / Register_Width,
      CUR_BUF_CFG_A         => 16#07_017c# / Register_Width,

      -- CPU transcoder clock select
      TRANSA_CLK_SEL        => 16#04_6140# / Register_Width,

   ---------------------------------------------------------------------------
   -- Pipe B registers
   ---------------------------------------------------------------------------

      -- pipe timing registers

      HTOTAL_B              => 16#06_1000# / Register_Width,
      HBLANK_B              => 16#06_1004# / Register_Width,
      HSYNC_B               => 16#06_1008# / Register_Width,
      VTOTAL_B              => 16#06_100c# / Register_Width,
      VBLANK_B              => 16#06_1010# / Register_Width,
      VSYNC_B               => 16#06_1014# / Register_Width,
      PIPEBSRC              => 16#06_101c# / Register_Width,
      PIPEBCONF             => 16#07_1008# / Register_Width,
      PIPEBMISC             => 16#07_1030# / Register_Width,
      TRANS_HTOTAL_B        => 16#0e_1000# / Register_Width,
      TRANS_HBLANK_B        => 16#0e_1004# / Register_Width,
      TRANS_HSYNC_B         => 16#0e_1008# / Register_Width,
      TRANS_VTOTAL_B        => 16#0e_100c# / Register_Width,
      TRANS_VBLANK_B        => 16#0e_1010# / Register_Width,
      TRANS_VSYNC_B         => 16#0e_1014# / Register_Width,
      TRANSB_DATA_M1        => 16#0e_1030# / Register_Width,
      TRANSB_DATA_N1        => 16#0e_1034# / Register_Width,
      TRANSB_DP_LINK_M1     => 16#0e_1040# / Register_Width,
      TRANSB_DP_LINK_N1     => 16#0e_1044# / Register_Width,
      PIPEB_DATA_M1         => 16#06_1030# / Register_Width,
      PIPEB_DATA_N1         => 16#06_1034# / Register_Width,
      PIPEB_LINK_M1         => 16#06_1040# / Register_Width,
      PIPEB_LINK_N1         => 16#06_1044# / Register_Width,
      PIPEB_GMCH_DATA_M     => 16#07_1050# / Register_Width,
      PIPEB_GMCH_DATA_N     => 16#07_1054# / Register_Width,
      PIPEB_GMCH_LINK_M     => 16#07_1060# / Register_Width,
      PIPEB_GMCH_LINK_N     => 16#07_1064# / Register_Width,
      PIPEB_DDI_FUNC_CTL    => 16#06_1400# / Register_Width,
      PIPEB_MSA_MISC        => 16#06_1410# / Register_Width,

      -- GMCH clock registers
      GMCH_DPLL_B           => 16#00_6018# / Register_Width,
      GMCH_FPB0             => 16#00_6048# / Register_Width,
      GMCH_FPB1             => 16#00_604c# / Register_Width,

      -- PCH clock registers
      PCH_DPLL_B            => 16#0c_6018# / Register_Width,
      PCH_FPB0              => 16#0c_6048# / Register_Width,
      PCH_FPB1              => 16#0c_604c# / Register_Width,

      -- panel fitter
      PFB_CTL_1             => 16#06_8880# / Register_Width,
      PFB_WIN_POS           => 16#06_8870# / Register_Width,
      PFB_WIN_SZ            => 16#06_8874# / Register_Width,
      PS_WIN_POS_1_B        => 16#06_8970# / Register_Width,
      PS_WIN_SZ_1_B         => 16#06_8974# / Register_Width,
      PS_CTRL_1_B           => 16#06_8980# / Register_Width,
      PS_WIN_POS_2_B        => 16#06_8a70# / Register_Width,
      PS_WIN_SZ_2_B         => 16#06_8a74# / Register_Width,
      PS_CTRL_2_B           => 16#06_8a80# / Register_Width,

      -- cursor control
      CURBCNTR              => 16#07_00c0# / Register_Width,   -- <= SNB
      CURBBASE              => 16#07_00c4# / Register_Width,   -- <= SNB
      CURBPOS               => 16#07_00c8# / Register_Width,   -- <= SNB
      CUR_CTL_B             => 16#07_1080# / Register_Width,
      CUR_BASE_B            => 16#07_1084# / Register_Width,
      CUR_POS_B             => 16#07_1088# / Register_Width,
      CUR_FBC_CTL_B         => 16#07_10a0# / Register_Width,

      -- display control
      DSPBCNTR              => 16#07_1180# / Register_Width,
      DSPBLINOFF            => 16#07_1184# / Register_Width,
      DSPBSTRIDE            => 16#07_1188# / Register_Width,
      PLANE_POS_1_B         => 16#07_118c# / Register_Width,
      PLANE_SIZE_1_B        => 16#07_1190# / Register_Width,
      DSPBSURF              => 16#07_119c# / Register_Width,
      DSPBTILEOFF           => 16#07_11a4# / Register_Width,

      -- sprite control
      SPBCNTR               => 16#07_1280# / Register_Width,

      -- FDI and PCH transcoder control
      FDI_TX_CTL_B          => 16#06_1100# / Register_Width, -- aliased by GMCH_ADPA
      FDI_RXB_CTL           => 16#0f_100c# / Register_Width,
      FDI_RX_MISC_B         => 16#0f_1010# / Register_Width,
      FDI_RXB_IIR           => 16#0f_1014# / Register_Width,
      FDI_RXB_IMR           => 16#0f_1018# / Register_Width,
      FDI_RXB_TUSIZE1       => 16#0f_1030# / Register_Width,
      TRANSBCONF            => 16#0f_1008# / Register_Width,
      TRANSB_CHICKEN2       => 16#0f_1064# / Register_Width,

      -- watermark registers
      WM_LINETIME_B         => 16#04_5274# / Register_Width,
      PLANE_WM_1_B_0        => 16#07_1240# / Register_Width,
      PLANE_WM_1_B_1        => 16#07_1244# / Register_Width,
      PLANE_WM_1_B_2        => 16#07_1248# / Register_Width,
      PLANE_WM_1_B_3        => 16#07_124c# / Register_Width,
      PLANE_WM_1_B_4        => 16#07_1250# / Register_Width,
      PLANE_WM_1_B_5        => 16#07_1254# / Register_Width,
      PLANE_WM_1_B_6        => 16#07_1258# / Register_Width,
      PLANE_WM_1_B_7        => 16#07_125c# / Register_Width,
      PLANE_BUF_CFG_1_B     => 16#07_127c# / Register_Width,
      CUR_WM_B_0            => 16#07_1140# / Register_Width,
      CUR_WM_B_1            => 16#07_1144# / Register_Width,
      CUR_WM_B_2            => 16#07_1148# / Register_Width,
      CUR_WM_B_3            => 16#07_114c# / Register_Width,
      CUR_WM_B_4            => 16#07_1150# / Register_Width,
      CUR_WM_B_5            => 16#07_1154# / Register_Width,
      CUR_WM_B_6            => 16#07_1158# / Register_Width,
      CUR_WM_B_7            => 16#07_115c# / Register_Width,
      CUR_BUF_CFG_B         => 16#07_117c# / Register_Width,

      -- CPU transcoder clock select
      TRANSB_CLK_SEL        => 16#04_6144# / Register_Width,

   ---------------------------------------------------------------------------
   -- Pipe C registers
   ---------------------------------------------------------------------------

      -- pipe timing registers

      HTOTAL_C              => 16#06_2000# / Register_Width,
      HBLANK_C              => 16#06_2004# / Register_Width,
      HSYNC_C               => 16#06_2008# / Register_Width,
      VTOTAL_C              => 16#06_200c# / Register_Width,
      VBLANK_C              => 16#06_2010# / Register_Width,
      VSYNC_C               => 16#06_2014# / Register_Width,
      PIPECSRC              => 16#06_201c# / Register_Width,
      PIPECCONF             => 16#07_2008# / Register_Width,
      PIPECMISC             => 16#07_2030# / Register_Width,
      TRANS_HTOTAL_C        => 16#0e_2000# / Register_Width,
      TRANS_HBLANK_C        => 16#0e_2004# / Register_Width,
      TRANS_HSYNC_C         => 16#0e_2008# / Register_Width,
      TRANS_VTOTAL_C        => 16#0e_200c# / Register_Width,
      TRANS_VBLANK_C        => 16#0e_2010# / Register_Width,
      TRANS_VSYNC_C         => 16#0e_2014# / Register_Width,
      TRANSC_DATA_M1        => 16#0e_2030# / Register_Width,
      TRANSC_DATA_N1        => 16#0e_2034# / Register_Width,
      TRANSC_DP_LINK_M1     => 16#0e_2040# / Register_Width,
      TRANSC_DP_LINK_N1     => 16#0e_2044# / Register_Width,
      PIPEC_DATA_M1         => 16#06_2030# / Register_Width,
      PIPEC_DATA_N1         => 16#06_2034# / Register_Width,
      PIPEC_LINK_M1         => 16#06_2040# / Register_Width,
      PIPEC_LINK_N1         => 16#06_2044# / Register_Width,
      PIPEC_DDI_FUNC_CTL    => 16#06_2400# / Register_Width,
      PIPEC_MSA_MISC        => 16#06_2410# / Register_Width,

      -- panel fitter
      PFC_CTL_1             => 16#06_9080# / Register_Width,
      PFC_WIN_POS           => 16#06_9070# / Register_Width,
      PFC_WIN_SZ            => 16#06_9074# / Register_Width,
      PS_WIN_POS_1_C        => 16#06_9170# / Register_Width,
      PS_WIN_SZ_1_C         => 16#06_9174# / Register_Width,
      PS_CTRL_1_C           => 16#06_9180# / Register_Width,

      -- cursor control
      CUR_CTL_C             => 16#07_2080# / Register_Width,
      CUR_BASE_C            => 16#07_2084# / Register_Width,
      CUR_POS_C             => 16#07_2088# / Register_Width,
      CUR_FBC_CTL_C         => 16#07_20a0# / Register_Width,

      -- display control
      DSPCCNTR              => 16#07_2180# / Register_Width,
      DSPCLINOFF            => 16#07_2184# / Register_Width,
      DSPCSTRIDE            => 16#07_2188# / Register_Width,
      PLANE_POS_1_C         => 16#07_218c# / Register_Width,
      PLANE_SIZE_1_C        => 16#07_2190# / Register_Width,
      DSPCSURF              => 16#07_219c# / Register_Width,
      DSPCTILEOFF           => 16#07_21a4# / Register_Width,

      -- sprite control
      SPCCNTR               => 16#07_2280# / Register_Width,

      -- PCH transcoder control
      FDI_TX_CTL_C          => 16#06_2100# / Register_Width,
      FDI_RXC_CTL           => 16#0f_200c# / Register_Width,
      FDI_RX_MISC_C         => 16#0f_2010# / Register_Width,
      FDI_RXC_IIR           => 16#0f_2014# / Register_Width,
      FDI_RXC_IMR           => 16#0f_2018# / Register_Width,
      FDI_RXC_TUSIZE1       => 16#0f_2030# / Register_Width,
      TRANSCCONF            => 16#0f_2008# / Register_Width,
      TRANSC_CHICKEN2       => 16#0f_2064# / Register_Width,

      -- watermark registers
      WM_LINETIME_C         => 16#04_5278# / Register_Width,
      PLANE_WM_1_C_0        => 16#07_2240# / Register_Width,
      PLANE_WM_1_C_1        => 16#07_2244# / Register_Width,
      PLANE_WM_1_C_2        => 16#07_2248# / Register_Width,
      PLANE_WM_1_C_3        => 16#07_224c# / Register_Width,
      PLANE_WM_1_C_4        => 16#07_2250# / Register_Width,
      PLANE_WM_1_C_5        => 16#07_2254# / Register_Width,
      PLANE_WM_1_C_6        => 16#07_2258# / Register_Width,
      PLANE_WM_1_C_7        => 16#07_225c# / Register_Width,
      PLANE_BUF_CFG_1_C     => 16#07_227c# / Register_Width,
      CUR_WM_C_0            => 16#07_2140# / Register_Width,
      CUR_WM_C_1            => 16#07_2144# / Register_Width,
      CUR_WM_C_2            => 16#07_2148# / Register_Width,
      CUR_WM_C_3            => 16#07_214c# / Register_Width,
      CUR_WM_C_4            => 16#07_2150# / Register_Width,
      CUR_WM_C_5            => 16#07_2154# / Register_Width,
      CUR_WM_C_6            => 16#07_2158# / Register_Width,
      CUR_WM_C_7            => 16#07_215c# / Register_Width,
      CUR_BUF_CFG_C         => 16#07_217c# / Register_Width,

      -- CPU transcoder clock select
      TRANSC_CLK_SEL        => 16#04_6148# / Register_Width,

   ---------------------------------------------------------------------------
   -- Pipe EDP registers
   ---------------------------------------------------------------------------

      -- pipe timing registers

      HTOTAL_EDP            => 16#06_f000# / Register_Width,
      HBLANK_EDP            => 16#06_f004# / Register_Width,
      HSYNC_EDP             => 16#06_f008# / Register_Width,
      VTOTAL_EDP            => 16#06_f00c# / Register_Width,
      VBLANK_EDP            => 16#06_f010# / Register_Width,
      VSYNC_EDP             => 16#06_f014# / Register_Width,
      PIPE_EDP_CONF         => 16#07_f008# / Register_Width,
      PIPE_EDP_DATA_M1      => 16#06_f030# / Register_Width,
      PIPE_EDP_DATA_N1      => 16#06_f034# / Register_Width,
      PIPE_EDP_LINK_M1      => 16#06_f040# / Register_Width,
      PIPE_EDP_LINK_N1      => 16#06_f044# / Register_Width,
      PIPE_EDP_DDI_FUNC_CTL => 16#06_f400# / Register_Width,
      PIPE_EDP_MSA_MISC     => 16#06_f410# / Register_Width,

      -- PSR registers
      SRD_CTL               => 16#06_4800# / Register_Width,
      SRD_CTL_A             => 16#06_0800# / Register_Width,
      SRD_CTL_B             => 16#06_1800# / Register_Width,
      SRD_CTL_C             => 16#06_2800# / Register_Width,
      SRD_CTL_EDP           => 16#06_f800# / Register_Width,
      SRD_STATUS            => 16#06_4840# / Register_Width,
      SRD_STATUS_A          => 16#06_0840# / Register_Width,
      SRD_STATUS_B          => 16#06_1840# / Register_Width,
      SRD_STATUS_C          => 16#06_2840# / Register_Width,
      SRD_STATUS_EDP        => 16#06_f840# / Register_Width,

      -- DDI registers
      DDI_BUF_CTL_A         => 16#06_4000# / Register_Width, -- aliased by DP_CTL_A
      DDI_BUF_TRANS_A_S0T1  => 16#06_4e00# / Register_Width,
      DDI_BUF_TRANS_A_S0T2  => 16#06_4e04# / Register_Width,
      DDI_BUF_TRANS_A_S1T1  => 16#06_4e08# / Register_Width,
      DDI_BUF_TRANS_A_S1T2  => 16#06_4e0c# / Register_Width,
      DDI_BUF_TRANS_A_S2T1  => 16#06_4e10# / Register_Width,
      DDI_BUF_TRANS_A_S2T2  => 16#06_4e14# / Register_Width,
      DDI_BUF_TRANS_A_S3T1  => 16#06_4e18# / Register_Width,
      DDI_BUF_TRANS_A_S3T2  => 16#06_4e1c# / Register_Width,
      DDI_BUF_TRANS_A_S4T1  => 16#06_4e20# / Register_Width,
      DDI_BUF_TRANS_A_S4T2  => 16#06_4e24# / Register_Width,
      DDI_BUF_TRANS_A_S5T1  => 16#06_4e28# / Register_Width,
      DDI_BUF_TRANS_A_S5T2  => 16#06_4e2c# / Register_Width,
      DDI_BUF_TRANS_A_S6T1  => 16#06_4e30# / Register_Width,
      DDI_BUF_TRANS_A_S6T2  => 16#06_4e34# / Register_Width,
      DDI_BUF_TRANS_A_S7T1  => 16#06_4e38# / Register_Width,
      DDI_BUF_TRANS_A_S7T2  => 16#06_4e3c# / Register_Width,
      DDI_BUF_TRANS_A_S8T1  => 16#06_4e40# / Register_Width,
      DDI_BUF_TRANS_A_S8T2  => 16#06_4e44# / Register_Width,
      DDI_BUF_TRANS_A_S9T1  => 16#06_4e48# / Register_Width,
      DDI_BUF_TRANS_A_S9T2  => 16#06_4e4c# / Register_Width,
      DDI_AUX_CTL_A         => 16#06_4010# / Register_Width, -- aliased by DP_AUX_CTL_A
      DDI_AUX_DATA_A_1      => 16#06_4014# / Register_Width, -- aliased by DP_AUX_DATA_A_1
      DDI_AUX_DATA_A_2      => 16#06_4018# / Register_Width, -- aliased by DP_AUX_DATA_A_2
      DDI_AUX_DATA_A_3      => 16#06_401c# / Register_Width, -- aliased by DP_AUX_DATA_A_3
      DDI_AUX_DATA_A_4      => 16#06_4020# / Register_Width, -- aliased by DP_AUX_DATA_A_4
      DDI_AUX_DATA_A_5      => 16#06_4024# / Register_Width, -- aliased by DP_AUX_DATA_A_5
      DDI_AUX_MUTEX_A       => 16#06_402c# / Register_Width,

      DDI_BUF_CTL_B         => 16#06_4100# / Register_Width, -- aliased by GMCH_DP_B
      DDI_BUF_TRANS_B_S0T1  => 16#06_4e60# / Register_Width,
      DDI_BUF_TRANS_B_S0T2  => 16#06_4e64# / Register_Width,
      DDI_BUF_TRANS_B_S1T1  => 16#06_4e68# / Register_Width,
      DDI_BUF_TRANS_B_S1T2  => 16#06_4e6c# / Register_Width,
      DDI_BUF_TRANS_B_S2T1  => 16#06_4e70# / Register_Width,
      DDI_BUF_TRANS_B_S2T2  => 16#06_4e74# / Register_Width,
      DDI_BUF_TRANS_B_S3T1  => 16#06_4e78# / Register_Width,
      DDI_BUF_TRANS_B_S3T2  => 16#06_4e7c# / Register_Width,
      DDI_BUF_TRANS_B_S4T1  => 16#06_4e80# / Register_Width,
      DDI_BUF_TRANS_B_S4T2  => 16#06_4e84# / Register_Width,
      DDI_BUF_TRANS_B_S5T1  => 16#06_4e88# / Register_Width,
      DDI_BUF_TRANS_B_S5T2  => 16#06_4e8c# / Register_Width,
      DDI_BUF_TRANS_B_S6T1  => 16#06_4e90# / Register_Width,
      DDI_BUF_TRANS_B_S6T2  => 16#06_4e94# / Register_Width,
      DDI_BUF_TRANS_B_S7T1  => 16#06_4e98# / Register_Width,
      DDI_BUF_TRANS_B_S7T2  => 16#06_4e9c# / Register_Width,
      DDI_BUF_TRANS_B_S8T1  => 16#06_4ea0# / Register_Width,
      DDI_BUF_TRANS_B_S8T2  => 16#06_4ea4# / Register_Width,
      DDI_BUF_TRANS_B_S9T1  => 16#06_4ea8# / Register_Width,
      DDI_BUF_TRANS_B_S9T2  => 16#06_4eac# / Register_Width,
      DDI_AUX_CTL_B         => 16#06_4110# / Register_Width,
      DDI_AUX_DATA_B_1      => 16#06_4114# / Register_Width,
      DDI_AUX_DATA_B_2      => 16#06_4118# / Register_Width,
      DDI_AUX_DATA_B_3      => 16#06_411c# / Register_Width,
      DDI_AUX_DATA_B_4      => 16#06_4120# / Register_Width,
      DDI_AUX_DATA_B_5      => 16#06_4124# / Register_Width,
      DDI_AUX_MUTEX_B       => 16#06_412c# / Register_Width,

      DDI_BUF_CTL_C         => 16#06_4200# / Register_Width, -- aliased by GMCH_DP_C
      DDI_BUF_TRANS_C_S0T1  => 16#06_4ec0# / Register_Width,
      DDI_BUF_TRANS_C_S0T2  => 16#06_4ec4# / Register_Width,
      DDI_BUF_TRANS_C_S1T1  => 16#06_4ec8# / Register_Width,
      DDI_BUF_TRANS_C_S1T2  => 16#06_4ecc# / Register_Width,
      DDI_BUF_TRANS_C_S2T1  => 16#06_4ed0# / Register_Width,
      DDI_BUF_TRANS_C_S2T2  => 16#06_4ed4# / Register_Width,
      DDI_BUF_TRANS_C_S3T1  => 16#06_4ed8# / Register_Width,
      DDI_BUF_TRANS_C_S3T2  => 16#06_4edc# / Register_Width,
      DDI_BUF_TRANS_C_S4T1  => 16#06_4ee0# / Register_Width,
      DDI_BUF_TRANS_C_S4T2  => 16#06_4ee4# / Register_Width,
      DDI_BUF_TRANS_C_S5T1  => 16#06_4ee8# / Register_Width,
      DDI_BUF_TRANS_C_S5T2  => 16#06_4eec# / Register_Width,
      DDI_BUF_TRANS_C_S6T1  => 16#06_4ef0# / Register_Width,
      DDI_BUF_TRANS_C_S6T2  => 16#06_4ef4# / Register_Width,
      DDI_BUF_TRANS_C_S7T1  => 16#06_4ef8# / Register_Width,
      DDI_BUF_TRANS_C_S7T2  => 16#06_4efc# / Register_Width,
      DDI_BUF_TRANS_C_S8T1  => 16#06_4f00# / Register_Width,
      DDI_BUF_TRANS_C_S8T2  => 16#06_4f04# / Register_Width,
      DDI_BUF_TRANS_C_S9T1  => 16#06_4f08# / Register_Width,
      DDI_BUF_TRANS_C_S9T2  => 16#06_4f0c# / Register_Width,
      DDI_AUX_CTL_C         => 16#06_4210# / Register_Width,
      DDI_AUX_DATA_C_1      => 16#06_4214# / Register_Width,
      DDI_AUX_DATA_C_2      => 16#06_4218# / Register_Width,
      DDI_AUX_DATA_C_3      => 16#06_421c# / Register_Width,
      DDI_AUX_DATA_C_4      => 16#06_4220# / Register_Width,
      DDI_AUX_DATA_C_5      => 16#06_4224# / Register_Width,
      DDI_AUX_MUTEX_C       => 16#06_422c# / Register_Width,

      DDI_BUF_CTL_D         => 16#06_4300# / Register_Width, -- aliased by GMCH_DP_D
      DDI_BUF_TRANS_D_S0T1  => 16#06_4f20# / Register_Width,
      DDI_BUF_TRANS_D_S0T2  => 16#06_4f24# / Register_Width,
      DDI_BUF_TRANS_D_S1T1  => 16#06_4f28# / Register_Width,
      DDI_BUF_TRANS_D_S1T2  => 16#06_4f2c# / Register_Width,
      DDI_BUF_TRANS_D_S2T1  => 16#06_4f30# / Register_Width,
      DDI_BUF_TRANS_D_S2T2  => 16#06_4f34# / Register_Width,
      DDI_BUF_TRANS_D_S3T1  => 16#06_4f38# / Register_Width,
      DDI_BUF_TRANS_D_S3T2  => 16#06_4f3c# / Register_Width,
      DDI_BUF_TRANS_D_S4T1  => 16#06_4f40# / Register_Width,
      DDI_BUF_TRANS_D_S4T2  => 16#06_4f44# / Register_Width,
      DDI_BUF_TRANS_D_S5T1  => 16#06_4f48# / Register_Width,
      DDI_BUF_TRANS_D_S5T2  => 16#06_4f4c# / Register_Width,
      DDI_BUF_TRANS_D_S6T1  => 16#06_4f50# / Register_Width,
      DDI_BUF_TRANS_D_S6T2  => 16#06_4f54# / Register_Width,
      DDI_BUF_TRANS_D_S7T1  => 16#06_4f58# / Register_Width,
      DDI_BUF_TRANS_D_S7T2  => 16#06_4f5c# / Register_Width,
      DDI_BUF_TRANS_D_S8T1  => 16#06_4f60# / Register_Width,
      DDI_BUF_TRANS_D_S8T2  => 16#06_4f64# / Register_Width,
      DDI_BUF_TRANS_D_S9T1  => 16#06_4f68# / Register_Width,
      DDI_BUF_TRANS_D_S9T2  => 16#06_4f6c# / Register_Width,
      DDI_AUX_CTL_D         => 16#06_4310# / Register_Width,
      DDI_AUX_DATA_D_1      => 16#06_4314# / Register_Width,
      DDI_AUX_DATA_D_2      => 16#06_4318# / Register_Width,
      DDI_AUX_DATA_D_3      => 16#06_431c# / Register_Width,
      DDI_AUX_DATA_D_4      => 16#06_4320# / Register_Width,
      DDI_AUX_DATA_D_5      => 16#06_4324# / Register_Width,
      DDI_AUX_MUTEX_D       => 16#06_432c# / Register_Width,

      DDI_BUF_CTL_E         => 16#06_4400# / Register_Width,
      DDI_BUF_TRANS_E_S0T1  => 16#06_4f80# / Register_Width,
      DDI_BUF_TRANS_E_S0T2  => 16#06_4f84# / Register_Width,
      DDI_BUF_TRANS_E_S1T1  => 16#06_4f88# / Register_Width,
      DDI_BUF_TRANS_E_S1T2  => 16#06_4f8c# / Register_Width,
      DDI_BUF_TRANS_E_S2T1  => 16#06_4f90# / Register_Width,
      DDI_BUF_TRANS_E_S2T2  => 16#06_4f94# / Register_Width,
      DDI_BUF_TRANS_E_S3T1  => 16#06_4f98# / Register_Width,
      DDI_BUF_TRANS_E_S3T2  => 16#06_4f9c# / Register_Width,
      DDI_BUF_TRANS_E_S4T1  => 16#06_4fa0# / Register_Width,
      DDI_BUF_TRANS_E_S4T2  => 16#06_4fa4# / Register_Width,
      DDI_BUF_TRANS_E_S5T1  => 16#06_4fa8# / Register_Width,
      DDI_BUF_TRANS_E_S5T2  => 16#06_4fac# / Register_Width,
      DDI_BUF_TRANS_E_S6T1  => 16#06_4fb0# / Register_Width,
      DDI_BUF_TRANS_E_S6T2  => 16#06_4fb4# / Register_Width,
      DDI_BUF_TRANS_E_S7T1  => 16#06_4fb8# / Register_Width,
      DDI_BUF_TRANS_E_S7T2  => 16#06_4fbc# / Register_Width,
      DDI_BUF_TRANS_E_S8T1  => 16#06_4fc0# / Register_Width,
      DDI_BUF_TRANS_E_S8T2  => 16#06_4fc4# / Register_Width,
      DDI_BUF_TRANS_E_S9T1  => 16#06_4fc8# / Register_Width,
      DDI_BUF_TRANS_E_S9T2  => 16#06_4fcc# / Register_Width,
      DP_TP_CTL_A           => 16#06_4040# / Register_Width,
      DP_TP_CTL_B           => 16#06_4140# / Register_Width,
      DP_TP_CTL_C           => 16#06_4240# / Register_Width,
      DP_TP_CTL_D           => 16#06_4340# / Register_Width,
      DP_TP_CTL_E           => 16#06_4440# / Register_Width,
      DP_TP_STATUS_B        => 16#06_4144# / Register_Width,
      DP_TP_STATUS_C        => 16#06_4244# / Register_Width,
      DP_TP_STATUS_D        => 16#06_4344# / Register_Width,
      DP_TP_STATUS_E        => 16#06_4444# / Register_Width,
      PORT_CLK_SEL_DDIA     => 16#04_6100# / Register_Width,
      PORT_CLK_SEL_DDIB     => 16#04_6104# / Register_Width,
      PORT_CLK_SEL_DDIC     => 16#04_6108# / Register_Width,
      PORT_CLK_SEL_DDID     => 16#04_610c# / Register_Width,
      PORT_CLK_SEL_DDIE     => 16#04_6110# / Register_Width,

      -- Haswell LCPLL registers
      LCPLL_CTL             => 16#13_0040# / Register_Width,

      -- Skylake I_boost configuration
      DISPIO_CR_TX_BMU_CR0  => 16#06_c00c# / Register_Width,

      -- Skylake DPLL registers
      DPLL1_CFGR1           => 16#06_c040# / Register_Width,
      DPLL1_CFGR2           => 16#06_c044# / Register_Width,
      DPLL2_CFGR1           => 16#06_c048# / Register_Width,
      DPLL2_CFGR2           => 16#06_c04c# / Register_Width,
      DPLL3_CFGR1           => 16#06_c050# / Register_Width,
      DPLL3_CFGR2           => 16#06_c054# / Register_Width,
      DPLL_CTRL1            => 16#06_c058# / Register_Width,
      DPLL_CTRL2            => 16#06_c05c# / Register_Width,
      DPLL_STATUS           => 16#06_c060# / Register_Width,

      -- CD CLK register
      CDCLK_CTL             => 16#04_6000# / Register_Width,
      CDCLK_FREQ            => 16#04_6200# / Register_Width,

      -- Skylake LCPLL registers
      LCPLL1_CTL            => 16#04_6010# / Register_Width,
      LCPLL2_CTL            => 16#04_6014# / Register_Width,

      -- SPLL register
      SPLL_CTL              => 16#04_6020# / Register_Width,

      -- WRPLL registers
      WRPLL_CTL_1           => 16#04_6040# / Register_Width,
      WRPLL_CTL_2           => 16#04_6060# / Register_Width,

      -- Broxton Display Engine PLL registers
      BXT_DE_PLL_CTL        => 16#06_d000# / Register_Width,
      BXT_DE_PLL_ENABLE     => 16#04_6070# / Register_Width,

      -- Broxton DDI PHY PLL registers
      BXT_PORT_PLL_ENABLE_A   => 16#04_6074# / Register_Width,
      BXT_PORT_PLL_ENABLE_B   => 16#04_6078# / Register_Width,
      BXT_PORT_PLL_ENABLE_C   => 16#04_607c# / Register_Width,
      BXT_PORT_PLL_EBB_0_A    => 16#16_2034# / Register_Width,
      BXT_PORT_PLL_EBB_4_A    => 16#16_2038# / Register_Width,
      BXT_PORT_PLL_0_A        => 16#16_2100# / Register_Width,
      BXT_PORT_PLL_1_A        => 16#16_2104# / Register_Width,
      BXT_PORT_PLL_2_A        => 16#16_2108# / Register_Width,
      BXT_PORT_PLL_3_A        => 16#16_210c# / Register_Width,
      BXT_PORT_PLL_6_A        => 16#16_2118# / Register_Width,
      BXT_PORT_PLL_8_A        => 16#16_2120# / Register_Width,
      BXT_PORT_PLL_9_A        => 16#16_2124# / Register_Width,
      BXT_PORT_PLL_10_A       => 16#16_2128# / Register_Width,
      BXT_PORT_PLL_EBB_0_B    => 16#06_c034# / Register_Width,
      BXT_PORT_PLL_EBB_4_B    => 16#06_c038# / Register_Width,
      BXT_PORT_PLL_0_B        => 16#06_c100# / Register_Width,
      BXT_PORT_PLL_1_B        => 16#06_c104# / Register_Width,
      BXT_PORT_PLL_2_B        => 16#06_c108# / Register_Width,
      BXT_PORT_PLL_3_B        => 16#06_c10c# / Register_Width,
      BXT_PORT_PLL_6_B        => 16#06_c118# / Register_Width,
      BXT_PORT_PLL_8_B        => 16#06_c120# / Register_Width,
      BXT_PORT_PLL_9_B        => 16#06_c124# / Register_Width,
      BXT_PORT_PLL_10_B       => 16#06_c128# / Register_Width,
      BXT_PORT_PLL_EBB_0_C    => 16#06_c340# / Register_Width,
      BXT_PORT_PLL_EBB_4_C    => 16#06_c344# / Register_Width,
      BXT_PORT_PLL_0_C        => 16#06_c380# / Register_Width,
      BXT_PORT_PLL_1_C        => 16#06_c384# / Register_Width,
      BXT_PORT_PLL_2_C        => 16#06_c388# / Register_Width,
      BXT_PORT_PLL_3_C        => 16#06_c38c# / Register_Width,
      BXT_PORT_PLL_6_C        => 16#06_c398# / Register_Width,
      BXT_PORT_PLL_8_C        => 16#06_c3a0# / Register_Width,
      BXT_PORT_PLL_9_C        => 16#06_c3a4# / Register_Width,
      BXT_PORT_PLL_10_C       => 16#06_c3a8# / Register_Width,

      -- Broxton DDI PHY PCS? registers
      BXT_PORT_PCS_DW10_01_A  => 16#16_2428# / Register_Width,
      BXT_PORT_PCS_DW12_01_A  => 16#16_2430# / Register_Width,
      BXT_PORT_PCS_DW10_GRP_A => 16#16_2c28# / Register_Width,
      BXT_PORT_PCS_DW12_GRP_A => 16#16_2c30# / Register_Width,
      BXT_PORT_PCS_DW10_01_B  => 16#06_c428# / Register_Width,
      BXT_PORT_PCS_DW12_01_B  => 16#06_c430# / Register_Width,
      BXT_PORT_PCS_DW10_01_C  => 16#06_c828# / Register_Width,
      BXT_PORT_PCS_DW12_01_C  => 16#06_c830# / Register_Width,
      BXT_PORT_PCS_DW10_GRP_B => 16#06_cc28# / Register_Width,
      BXT_PORT_PCS_DW12_GRP_B => 16#06_cc30# / Register_Width,
      BXT_PORT_PCS_DW10_GRP_C => 16#06_ce28# / Register_Width,
      BXT_PORT_PCS_DW12_GRP_C => 16#06_ce30# / Register_Width,

      -- Broxton DDI PHY registers
      BXT_P_CR_GT_DISP_PWRON  => 16#13_8090# / Register_Width,
      BXT_PHY_CTL_A           => 16#06_4c00# / Register_Width,
      BXT_PHY_CTL_B           => 16#06_4c10# / Register_Width,
      BXT_PHY_CTL_C           => 16#06_4c20# / Register_Width,
      BXT_PHY_CTL_FAM_EDP     => 16#06_4c80# / Register_Width,
      BXT_PHY_CTL_FAM_DDI     => 16#06_4c90# / Register_Width,

      -- Broxton DDI PHY common lane registers
      BXT_PORT_CL1CM_DW0_A    => 16#16_2000# / Register_Width,
      BXT_PORT_CL1CM_DW0_BC   => 16#06_c000# / Register_Width,
      BXT_PORT_CL1CM_DW9_A    => 16#16_2024# / Register_Width,
      BXT_PORT_CL1CM_DW9_BC   => 16#06_c024# / Register_Width,
      BXT_PORT_CL1CM_DW10_A   => 16#16_2028# / Register_Width,
      BXT_PORT_CL1CM_DW10_BC  => 16#06_c028# / Register_Width,
      BXT_PORT_CL1CM_DW28_A   => 16#16_2070# / Register_Width,
      BXT_PORT_CL1CM_DW28_BC  => 16#06_c070# / Register_Width,
      BXT_PORT_CL1CM_DW30_A   => 16#16_2078# / Register_Width,
      BXT_PORT_CL1CM_DW30_BC  => 16#06_c078# / Register_Width,
      BXT_PORT_CL2CM_DW6_BC   => 16#06_c358# / Register_Width,

      -- Broxton DDI PHY TX lane registers
      BXT_PORT_TX_DW2_LN0_A   => 16#16_2508# / Register_Width,
      BXT_PORT_TX_DW3_LN0_A   => 16#16_250c# / Register_Width,
      BXT_PORT_TX_DW4_LN0_A   => 16#16_2510# / Register_Width,
      BXT_PORT_TX_DW14_LN0_A  => 16#16_2538# / Register_Width,
      BXT_PORT_TX_DW14_LN1_A  => 16#16_25b8# / Register_Width,
      BXT_PORT_TX_DW14_LN2_A  => 16#16_2738# / Register_Width,
      BXT_PORT_TX_DW14_LN3_A  => 16#16_27b8# / Register_Width,
      BXT_PORT_TX_DW2_GRP_A   => 16#16_2d08# / Register_Width,
      BXT_PORT_TX_DW3_GRP_A   => 16#16_2d0c# / Register_Width,
      BXT_PORT_TX_DW4_GRP_A   => 16#16_2d10# / Register_Width,
      BXT_PORT_TX_DW2_LN0_B   => 16#06_c508# / Register_Width,
      BXT_PORT_TX_DW3_LN0_B   => 16#06_c50c# / Register_Width,
      BXT_PORT_TX_DW4_LN0_B   => 16#06_c510# / Register_Width,
      BXT_PORT_TX_DW14_LN0_B  => 16#06_c538# / Register_Width,
      BXT_PORT_TX_DW14_LN1_B  => 16#06_c5b8# / Register_Width,
      BXT_PORT_TX_DW14_LN2_B  => 16#06_c738# / Register_Width,
      BXT_PORT_TX_DW14_LN3_B  => 16#06_c7b8# / Register_Width,
      BXT_PORT_TX_DW2_GRP_B   => 16#06_cd08# / Register_Width,
      BXT_PORT_TX_DW3_GRP_B   => 16#06_cd0c# / Register_Width,
      BXT_PORT_TX_DW4_GRP_B   => 16#06_cd10# / Register_Width,
      BXT_PORT_TX_DW2_LN0_C   => 16#06_c908# / Register_Width,
      BXT_PORT_TX_DW3_LN0_C   => 16#06_c90c# / Register_Width,
      BXT_PORT_TX_DW4_LN0_C   => 16#06_c910# / Register_Width,
      BXT_PORT_TX_DW14_LN0_C  => 16#06_c938# / Register_Width,
      BXT_PORT_TX_DW14_LN1_C  => 16#06_c9b8# / Register_Width,
      BXT_PORT_TX_DW14_LN2_C  => 16#06_cb38# / Register_Width,
      BXT_PORT_TX_DW14_LN3_C  => 16#06_cbb8# / Register_Width,
      BXT_PORT_TX_DW2_GRP_C   => 16#06_cf08# / Register_Width,
      BXT_PORT_TX_DW3_GRP_C   => 16#06_cf0c# / Register_Width,
      BXT_PORT_TX_DW4_GRP_C   => 16#06_cf10# / Register_Width,

      -- Broxton DDI PHY ref registers
      BXT_PORT_REF_DW3_A      => 16#16_218c# / Register_Width,
      BXT_PORT_REF_DW3_BC     => 16#06_c18c# / Register_Width,
      BXT_PORT_REF_DW6_A      => 16#16_2198# / Register_Width,
      BXT_PORT_REF_DW6_BC     => 16#06_c198# / Register_Width,
      BXT_PORT_REF_DW8_A      => 16#16_21a0# / Register_Width,
      BXT_PORT_REF_DW8_BC     => 16#06_c1a0# / Register_Width,

      -- Power Down Well registers
      PWR_WELL_CTL_BIOS     => 16#04_5400# / Register_Width,
      PWR_WELL_CTL_DRIVER   => 16#04_5404# / Register_Width,
      PWR_WELL_CTL_KVMR     => 16#04_5408# / Register_Width,
      PWR_WELL_CTL_DEBUG    => 16#04_540c# / Register_Width,
      PWR_WELL_CTL5         => 16#04_5410# / Register_Width,
      PWR_WELL_CTL6         => 16#04_5414# / Register_Width,

      -- class Panel registers
      GMCH_PP_STATUS        => 16#06_1200# / Register_Width,
      GMCH_PP_CONTROL       => 16#06_1204# / Register_Width,
      GMCH_PP_ON_DELAYS     => 16#06_1208# / Register_Width,
      GMCH_PP_OFF_DELAYS    => 16#06_120c# / Register_Width,
      GMCH_PP_DIVISOR       => 16#06_1210# / Register_Width,
      GMCH_PFIT_CONTROL     => 16#06_1230# / Register_Width,
      PCH_PP_STATUS         => 16#0c_7200# / Register_Width, -- aliased with BXT_PP_STATUS_1
      PCH_PP_CONTROL        => 16#0c_7204# / Register_Width, -- aliased with BXT_PP_CONTROL_1
      PCH_PP_ON_DELAYS      => 16#0c_7208# / Register_Width, -- aliased with BXT_PP_ON_DELAYS_1
      PCH_PP_OFF_DELAYS     => 16#0c_720c# / Register_Width, -- aliased with BXT_PP_OFF_DELAYS_1
      PCH_PP_DIVISOR        => 16#0c_7210# / Register_Width,
      BXT_PP_STATUS_2       => 16#0c_7300# / Register_Width,
      BXT_PP_CONTROL_2      => 16#0c_7304# / Register_Width,
      BXT_PP_ON_DELAYS_2    => 16#0c_7308# / Register_Width,
      BXT_PP_OFF_DELAYS_2   => 16#0c_730c# / Register_Width,
      BLC_PWM_CPU_CTL       => 16#04_8254# / Register_Width,
      BLC_PWM_CPU_CTL2      => 16#04_8250# / Register_Width,
      BLC_PWM_PCH_CTL1      => 16#0c_8250# / Register_Width, -- aliased with BXT_BLC_PWM_CTL_1
      BLC_PWM_PCH_CTL2      => 16#0c_8254# / Register_Width, -- aliased with BXT_BLC_PWM_FREQ_1
      BXT_BLC_PWM_DUTY_1    => 16#0c_8258# / Register_Width,
      BXT_BLC_PWM_CTL_2     => 16#0c_8350# / Register_Width,
      BXT_BLC_PWM_FREQ_2    => 16#0c_8354# / Register_Width,
      BXT_BLC_PWM_DUTY_2    => 16#0c_8358# / Register_Width,

      -- GMCH LVDS Connector Registers
      GMCH_LVDS             => 16#06_1180# / Register_Width,

      -- PCH LVDS Connector Registers
      PCH_LVDS              => 16#0e_1180# / Register_Width,

      -- PCH ADPA Connector Registers
      PCH_ADPA              => 16#0e_1100# / Register_Width,

      -- GMCH DVOB Connector Registers
      GMCH_SDVOB            => 16#06_1140# / Register_Width,

      -- PCH HDMIB Connector Registers
      PCH_HDMIB             => 16#0e_1140# / Register_Width,

      -- GMCH DVOC Connector Registers
      GMCH_SDVOC            => 16#06_1160# / Register_Width,

      -- PCH HDMIC Connector Registers
      PCH_HDMIC             => 16#0e_1150# / Register_Width,

      -- PCH HDMID Connector Registers
      PCH_HDMID             => 16#0e_1160# / Register_Width,

      -- Intel Registers
      DFSM                  => 16#05_1000# / Register_Width,
      CPU_VGACNTRL          => 16#04_1000# / Register_Width,
      GMCH_VGACNTRL         => 16#07_1400# / Register_Width,
      FUSE_STATUS           => 16#04_2000# / Register_Width,
      FUSE_STRAP            => 16#04_2014# / Register_Width,
      FBA_CFB_BASE          => 16#04_3200# / Register_Width,
      IPS_CTL               => 16#04_3408# / Register_Width,
      ARB_CTL               => 16#04_5000# / Register_Width,
      DBUF_CTL              => 16#04_5008# / Register_Width,
      NDE_RSTWRN_OPT        => 16#04_6408# / Register_Width,
      GEN8_CHICKEN_DCPR_1   => 16#04_6430# / Register_Width,
      PCH_DREF_CONTROL      => 16#0c_6200# / Register_Width,
      PCH_DPLL_SEL          => 16#0c_7000# / Register_Width,
      GT_MAILBOX            => 16#13_8124# / Register_Width,
      GT_MAILBOX_DATA       => 16#13_8128# / Register_Width,
      GT_MAILBOX_DATA_1     => 16#13_812c# / Register_Width,

      PCH_DP_B              => 16#0e_4100# / Register_Width,
      PCH_DP_AUX_CTL_B      => 16#0e_4110# / Register_Width,
      PCH_DP_AUX_DATA_B_1   => 16#0e_4114# / Register_Width,
      PCH_DP_AUX_DATA_B_2   => 16#0e_4118# / Register_Width,
      PCH_DP_AUX_DATA_B_3   => 16#0e_411c# / Register_Width,
      PCH_DP_AUX_DATA_B_4   => 16#0e_4120# / Register_Width,
      PCH_DP_AUX_DATA_B_5   => 16#0e_4124# / Register_Width,
      PCH_DP_C              => 16#0e_4200# / Register_Width,
      PCH_DP_AUX_CTL_C      => 16#0e_4210# / Register_Width,
      PCH_DP_AUX_DATA_C_1   => 16#0e_4214# / Register_Width,
      PCH_DP_AUX_DATA_C_2   => 16#0e_4218# / Register_Width,
      PCH_DP_AUX_DATA_C_3   => 16#0e_421c# / Register_Width,
      PCH_DP_AUX_DATA_C_4   => 16#0e_4220# / Register_Width,
      PCH_DP_AUX_DATA_C_5   => 16#0e_4224# / Register_Width,
      PCH_DP_D              => 16#0e_4300# / Register_Width,
      PCH_DP_AUX_CTL_D      => 16#0e_4310# / Register_Width,
      PCH_DP_AUX_DATA_D_1   => 16#0e_4314# / Register_Width,
      PCH_DP_AUX_DATA_D_2   => 16#0e_4318# / Register_Width,
      PCH_DP_AUX_DATA_D_3   => 16#0e_431c# / Register_Width,
      PCH_DP_AUX_DATA_D_4   => 16#0e_4320# / Register_Width,
      PCH_DP_AUX_DATA_D_5   => 16#0e_4324# / Register_Width,

      -- watermark registers
      WM1_LP_ILK            => 16#04_5108# / Register_Width,
      WM2_LP_ILK            => 16#04_510c# / Register_Width,
      WM3_LP_ILK            => 16#04_5110# / Register_Width,

      -- audio VID/DID
      AUD_VID_DID           => 16#06_5020# / Register_Width,
      PCH_AUD_VID_DID       => 16#0e_5020# / Register_Width,
      G4X_AUD_VID_DID       => 16#06_2020# / Register_Width,

      -- interrupt registers
      DEISR                 => 16#04_4000# / Register_Width,
      DEIMR                 => 16#04_4004# / Register_Width,
      DEIIR                 => 16#04_4008# / Register_Width,
      DEIER                 => 16#04_400c# / Register_Width,
      GTISR                 => 16#04_4010# / Register_Width,
      GTIMR                 => 16#04_4014# / Register_Width,
      GTIIR                 => 16#04_4018# / Register_Width,
      GTIER                 => 16#04_401c# / Register_Width,
      SDEISR                => 16#0c_4000# / Register_Width,
      SDEIMR                => 16#0c_4004# / Register_Width,
      SDEIIR                => 16#0c_4008# / Register_Width,
      SDEIER                => 16#0c_400c# / Register_Width,

      -- I2C stuff
      GMCH_GMBUS0           => 16#00_5100# / Register_Width,
      GMCH_GMBUS1           => 16#00_5104# / Register_Width,
      GMCH_GMBUS2           => 16#00_5108# / Register_Width,
      GMCH_GMBUS3           => 16#00_510c# / Register_Width,
      GMCH_GMBUS4           => 16#00_5110# / Register_Width,
      GMCH_GMBUS5           => 16#00_5120# / Register_Width,
      PCH_GMBUS0            => 16#0c_5100# / Register_Width,
      PCH_GMBUS1            => 16#0c_5104# / Register_Width,
      PCH_GMBUS2            => 16#0c_5108# / Register_Width,
      PCH_GMBUS3            => 16#0c_510c# / Register_Width,
      PCH_GMBUS4            => 16#0c_5110# / Register_Width,
      PCH_GMBUS5            => 16#0c_5120# / Register_Width,

      -- clock gating -- maybe have to touch this
      DSPCLK_GATE_D         => 16#04_2020# / Register_Width,
      PCH_FDI_CHICKEN_B_C   => 16#0c_2000# / Register_Width,
      PCH_DSPCLK_GATE_D     => 16#0c_2020# / Register_Width,

      -- hotplug and initial detection
      HOTPLUG_CTL           => 16#04_4030# / Register_Width,
      PORT_HOTPLUG_EN       => 16#06_1110# / Register_Width,
      PORT_HOTPLUG_STAT     => 16#06_1114# / Register_Width,
      SHOTPLUG_CTL          => 16#0c_4030# / Register_Width,
      SFUSE_STRAP           => 16#0c_2014# / Register_Width,

      -- Render Engine Command Streamer
      ARB_MODE              => 16#00_4030# / Register_Width,
      HWS_PGA               => 16#00_4080# / Register_Width,
      RCS_RING_BUFFER_TAIL  => 16#00_2030# / Register_Width,
      VCS_RING_BUFFER_TAIL  => 16#01_2030# / Register_Width,
      BCS_RING_BUFFER_TAIL  => 16#02_2030# / Register_Width,
      RCS_RING_BUFFER_HEAD  => 16#00_2034# / Register_Width,
      VCS_RING_BUFFER_HEAD  => 16#01_2034# / Register_Width,
      BCS_RING_BUFFER_HEAD  => 16#02_2034# / Register_Width,
      RCS_RING_BUFFER_STRT  => 16#00_2038# / Register_Width,
      VCS_RING_BUFFER_STRT  => 16#01_2038# / Register_Width,
      BCS_RING_BUFFER_STRT  => 16#02_2038# / Register_Width,
      RCS_RING_BUFFER_CTL   => 16#00_203c# / Register_Width,
      VCS_RING_BUFFER_CTL   => 16#01_203c# / Register_Width,
      BCS_RING_BUFFER_CTL   => 16#02_203c# / Register_Width,
      MI_MODE               => 16#00_209c# / Register_Width,
      INSTPM                => 16#00_20c0# / Register_Width,
      GAB_CTL_REG           => 16#02_4000# / Register_Width,
      PP_DCLV_HIGH          => 16#00_2220# / Register_Width,
      PP_DCLV_LOW           => 16#00_2228# / Register_Width,
      VCS_PP_DCLV_HIGH      => 16#01_2220# / Register_Width,
      VCS_PP_DCLV_LOW       => 16#01_2228# / Register_Width,
      BCS_PP_DCLV_HIGH      => 16#02_2220# / Register_Width,
      BCS_PP_DCLV_LOW       => 16#02_2228# / Register_Width,
      ILK_DISPLAY_CHICKEN2  => 16#04_2004# / Register_Width,
      UCGCTL1               => 16#00_9400# / Register_Width,
      UCGCTL2               => 16#00_9404# / Register_Width,
      MBCTL                 => 16#00_907c# / Register_Width,
      HWSTAM                => 16#00_2098# / Register_Width,
      VCS_HWSTAM            => 16#01_2098# / Register_Width,
      BCS_HWSTAM            => 16#02_2098# / Register_Width,
      IIR                   => 16#04_4028# / Register_Width,
      PIPE_FRMCNT_A         => 16#07_0040# / Register_Width,
      PIPE_FRMCNT_B         => 16#07_1040# / Register_Width,
      PIPE_FRMCNT_C         => 16#07_2040# / Register_Width,
      FBC_CTL               => 16#04_3208# / Register_Width,
      PIPE_VSYNCSHIFT_A     => 16#06_0028# / Register_Width,
      PIPE_VSYNCSHIFT_B     => 16#06_1028# / Register_Width,
      PIPE_VSYNCSHIFT_C     => 16#06_2028# / Register_Width,
      WM_PIPE_A             => 16#04_5100# / Register_Width,
      WM_PIPE_B             => 16#04_5104# / Register_Width,
      WM_PIPE_C             => 16#04_5200# / Register_Width,
      PIPE_SCANLINE_A       => 16#07_0000# / Register_Width,
      PIPE_SCANLINE_B       => 16#07_1000# / Register_Width,
      PIPE_SCANLINE_C       => 16#07_2000# / Register_Width,
      GFX_MODE              => 16#00_2520# / Register_Width,
      CACHE_MODE_0          => 16#00_2120# / Register_Width,
      SLEEP_PSMI_CONTROL    => 16#01_2050# / Register_Width,
      CTX_SIZE              => 16#00_21a0# / Register_Width,
      GAC_ECO_BITS          => 16#01_4090# / Register_Width,
      GAM_ECOCHK            => 16#00_4090# / Register_Width,
      QUIRK_02084           => 16#00_2084# / Register_Width,
      QUIRK_02090           => 16#00_2090# / Register_Width,
      GT_MODE               => 16#00_20d0# / Register_Width,
      QUIRK_F0060           => 16#0f_0060# / Register_Width,
      QUIRK_F1060           => 16#0f_1060# / Register_Width,
      QUIRK_F2060           => 16#0f_2060# / Register_Width,
      AUD_CNTRL_ST2         => 16#0e_50c0# / Register_Width,
      AUD_CNTL_ST_A         => 16#0e_50b4# / Register_Width,
      AUD_CNTL_ST_B         => 16#0e_51b4# / Register_Width,
      AUD_CNTL_ST_C         => 16#0e_52b4# / Register_Width,
      AUD_HDMIW_HDMIEDID_A  => 16#0e_5050# / Register_Width,
      AUD_HDMIW_HDMIEDID_B  => 16#0e_5150# / Register_Width,
      AUD_HDMIW_HDMIEDID_C  => 16#0e_5250# / Register_Width,
      AUD_CONFIG_A          => 16#0e_5000# / Register_Width,
      AUD_CONFIG_B          => 16#0e_5100# / Register_Width,
      AUD_CONFIG_C          => 16#0e_5200# / Register_Width,
      TRANS_DP_CTL_A        => 16#0e_0300# / Register_Width,
      TRANS_DP_CTL_B        => 16#0e_1300# / Register_Width,
      TRANS_DP_CTL_C        => 16#0e_2300# / Register_Width,
      TRANS_VSYNCSHIFT_A    => 16#0e_0028# / Register_Width,
      TRANS_VSYNCSHIFT_B    => 16#0e_1028# / Register_Width,
      TRANS_VSYNCSHIFT_C    => 16#0e_2028# / Register_Width,
      PCH_RAWCLK_FREQ       => 16#0c_6204# / Register_Width,
      QUIRK_C2004           => 16#0c_2004# / Register_Width,

      -- MCHBAR Mirror

      GMCH_CLKCFG           => 16#01_0c00# / Register_Width,
      GMCH_HPLLVCO_MOBILE   => 16#01_0c0f# / Register_Width,
      GMCH_HPLLVCO          => 16#01_0c38# / Register_Width);

   subtype Registers_Index is Registers_Invalid_Index range
      Registers_Invalid_Index'Succ (Invalid_Register) ..
      Registers_Invalid_Index'Last;

   -- aliased registers
   DP_CTL_A             : constant Registers_Index := DDI_BUF_CTL_A;
   GMCH_DP_B            : constant Registers_Index := DDI_BUF_CTL_B;
   GMCH_DP_C            : constant Registers_Index := DDI_BUF_CTL_C;
   GMCH_DP_D            : constant Registers_Index := DDI_BUF_CTL_D;
   DP_AUX_CTL_A         : constant Registers_Index := DDI_AUX_CTL_A;
   DP_AUX_DATA_A_1      : constant Registers_Index := DDI_AUX_DATA_A_1;
   DP_AUX_DATA_A_2      : constant Registers_Index := DDI_AUX_DATA_A_2;
   DP_AUX_DATA_A_3      : constant Registers_Index := DDI_AUX_DATA_A_3;
   DP_AUX_DATA_A_4      : constant Registers_Index := DDI_AUX_DATA_A_4;
   DP_AUX_DATA_A_5      : constant Registers_Index := DDI_AUX_DATA_A_5;
   ILK_DISPLAY_CHICKEN1 : constant Registers_Index := FUSE_STATUS;
   GMCH_ADPA            : constant Registers_Index := FDI_TX_CTL_B;
   GMCH_HDMIB           : constant Registers_Index := GMCH_SDVOB;
   GMCH_HDMIC           : constant Registers_Index := GMCH_SDVOC;
   CURACNTR             : constant Registers_Index := CUR_CTL_A;
   CURABASE             : constant Registers_Index := CUR_BASE_A;
   CURAPOS              : constant Registers_Index := CUR_POS_A;
   BXT_BLC_PWM_CTL_1    : constant Registers_Index := BLC_PWM_PCH_CTL1;
   BXT_BLC_PWM_FREQ_1   : constant Registers_Index := BLC_PWM_PCH_CTL2;

   ---------------------------------------------------------------------------

   Default_Timeout_MS : constant := 10;

   ---------------------------------------------------------------------------

   procedure Posting_Read
      (Register : in     Registers_Index)
   with
      Global  => (In_Out => Register_State),
      Depends => (Register_State =>+ (Register)),
      Pre     => True,
      Post    => True;

   pragma Warnings (GNATprove, Off, "unused variable ""Verbose""",
                    Reason => "Only used on debugging path");
   procedure Read
      (Register : in     Registers_Index;
       Value    :    out Word32;
       Verbose  : in     Boolean := True)
   with
      Global  => (In_Out => Register_State),
      Depends => ((Value, Register_State) => (Register, Register_State),
                  null  => Verbose),
      Pre     => True,
      Post    => True;
   pragma Warnings (GNATprove, On, "unused variable ""Verbose""");

   procedure Write
      (Register : Registers_Index;
       Value    : Word32)
   with
      Global  => (In_Out => Register_State),
      Depends => (Register_State => (Register, Register_State, Value)),
      Pre     => True,
      Post    => True;

   procedure Is_Set_Mask
      (Register : in     Registers_Index;
       Mask     : in     Word32;
       Result   :    out Boolean);

   pragma Warnings (GNATprove, Off, "unused initial value of ""Verbose""",
                    Reason => "Only used on debugging path");
   procedure Wait
     (Register : in     Registers_Index;
      Mask     : in     Word32;
      Value    : in     Word32;
      TOut_MS  : in     Natural := Default_Timeout_MS;
      Verbose  : in     Boolean := False;
      Success  :    out Boolean);
   procedure Wait
     (Register : Registers_Index;
      Mask     : Word32;
      Value    : Word32;
      TOut_MS  : Natural := Default_Timeout_MS;
      Verbose  : Boolean := False);

   procedure Wait_Set_Mask
     (Register : in     Registers_Index;
      Mask     : in     Word32;
      TOut_MS  : in     Natural := Default_Timeout_MS;
      Verbose  : in     Boolean := False;
      Success  :    out Boolean);
   procedure Wait_Set_Mask
     (Register : Registers_Index;
      Mask     : Word32;
      TOut_MS  : Natural := Default_Timeout_MS;
      Verbose  : Boolean := False);

   procedure Wait_Unset_Mask
     (Register : in     Registers_Index;
      Mask     : in     Word32;
      TOut_MS  : in     Natural := Default_Timeout_MS;
      Verbose  : in     Boolean := False;
      Success  :    out Boolean);
   procedure Wait_Unset_Mask
     (Register : Registers_Index;
      Mask     : Word32;
      TOut_MS  : Natural := Default_Timeout_MS;
      Verbose  : Boolean := False);
   pragma Warnings (GNATprove, On, "unused initial value of ""Verbose""");

   procedure Set_Mask
      (Register : Registers_Index;
       Mask     : Word32);

   procedure Unset_Mask
      (Register : Registers_Index;
       Mask     : Word32);

   procedure Unset_And_Set_Mask
      (Register   : Registers_Index;
       Mask_Unset : Word32;
       Mask_Set   : Word32);

   procedure Clear_Fences;

   procedure Add_Fence
     (First_Page  : in     GTT_Range;
      Last_Page   : in     GTT_Range;
      Tiling      : in     XY_Tiling;
      Pitch       : in     Natural;
      Success     :    out Boolean);

   procedure Remove_Fence (First_Page, Last_Page : GTT_Range);

   pragma Warnings (GNATprove, Off, "no check message justified by this",
                    Reason => "see Annotate aspects.");
   procedure Write_GTT
     (GTT_Page       : GTT_Range;
      Device_Address : GTT_Address_Type;
      Valid          : Boolean)
   with
      Global  =>
        (Input => Config.Variable,
         In_Out => GTT_State),
      Depends =>
        (GTT_State =>+ (Config.Variable, GTT_Page, Device_Address, Valid)),
      Annotate =>
        (GNATprove, Intentional,
         """GMA.State"" of ""Write_GTT"" not read",
         "Reading of Config_State depends on the platform configuration.");

   procedure Read_GTT
     (Device_Address :    out GTT_Address_Type;
      Valid          :    out Boolean;
      GTT_Page       : in     GTT_Range)
   with
      Global  =>
        (Input => Config.Variable,
         In_Out => GTT_State),
      Depends =>
        ((Device_Address, Valid, GTT_State) =>
           (Config.Variable, GTT_State, GTT_Page)),
      Annotate =>
        (GNATprove, Intentional,
         """GMA.State"" of ""Read_GTT"" not read",
         "Reading of Config_State depends on the platform configuration.");
   pragma Warnings (GNATprove, On, "no check message justified by this");

   procedure Set_Register_Base (Base : Word64; GTT_Base : Word64 := 0)
   with
      Global   => (Output => Address_State),
      Depends  => (Address_State => (Base, GTT_Base)),
      Pre      => True,
      Post     => True;

end HW.GFX.GMA.Registers;
