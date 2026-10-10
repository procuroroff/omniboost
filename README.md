# OmniBoost

> **Universal Low-Level Linux Hardware & Kernel Performance Governor**  
> Cross-platform, driver-agnostic hardware tuner for Intel, AMD, ARM CPUs, Intel/AMD/NVIDIA GPUs, and NVMe/SATA storage subsystems.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  OMNIBOOST v3.0 // UNIVERSAL LINUX HARDWARE & KERNEL GOVERNOR               │
│  CPU: Auto-Detect (Intel / AMD / ARM) | CORES: Dynamic Core Discovery       │
│  GPU: Auto-Detect (Intel i915 / AMD amdgpu / NVIDIA proprietary)            │
│  SUBSYSTEM: P-State / CPB / DPM / Block I/O / sysctl latency / PCIe ASPM    │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Why OmniBoost?

Unlike platform-specific tools, **OmniBoost** automatically discovers the host's underlying hardware topology and selects appropriate low-level kernel APIs:

- **Universal CPU Support:**
  - **Intel:** `intel_pstate` (HWP Dynamic Boost, unconstrained Turbo limits, min/max performance ceilings).
  - **AMD:** `amd_pstate` / `amd_pstate_epp` (Core Performance Boost / CPB, autonomous curves).
  - **Generic / ARM:** `cpufreq` governors (`performance`, `schedutil`, `powersave`), hardware EPP registers.
- **Universal GPU Support:**
  - **Intel:** Direct `i915` / `xe` frequency clamping (`RP0`, `RP1`, `RPn`, boost frequencies).
  - **AMD:** `amdgpu` dynamic power management (`power_dpm_force_performance_level` -> `high`, `auto`, `low`).
  - **NVIDIA:** Automated persistence mode (`nvidia-smi -pm 1`) and compute profile optimization.
- **Block Storage I/O Optimization:**
  - Automatic detection of drive types (NVMe SSD, SATA SSD, HDD).
  - Low-overhead I/O scheduler selection (`none` for NVMe, `mq-deadline`/`bfq` for SATA/rotational).
  - Dynamic read-ahead buffer tuning (2048 KB for burst performance).
- **Kernel Latency & Memory Pressure:**
  - PCIe ASPM (`performance`, `default`, `powersupersave`).
  - Memory paging (`vm.swappiness`, `vfs_cache_pressure`).
  - Interrupt overhead reduction (`nmi_watchdog` disable).
  - x86 Split-lock mitigation bypass for stutter-free gaming under Wine/Proton.

---

## Operating Profiles

| Profile | CPU Management | GPU Policy | Block I/O | Kernel & Bus |
| :--- | :--- | :--- | :--- | :--- |
| **Extreme** | 100% floor, EPP `performance`, Turbo/CPB unconstrained | Locked max clocks (Intel RP0 / AMD High / NVIDIA PM) | NVMe `none`, Read-ahead 2048k | ASPM: perf, Split-lock: bypass, NMI: 0 |
| **Balanced** | Dynamic HWP / Schedutil, EPP `balance_performance` | Dynamic DPM (Auto scaling) | Default schedulers | ASPM: default, Swappiness: 60 |
| **Powersave** | Turbo OFF, Capped P-State, EPP `power` | Low clock ceiling | Power-saving links | ASPM: powersupersave, Silent fans |

---

## Installation

```bash
git clone https://github.com/procuroroff/omniboost.git
cd omniboost
sudo ./install.sh
```

---

## Usage

### Interactive Terminal Interface
Run without arguments to enter the interactive menu:
```bash
omniboost
```

### Direct CLI Commands
```bash
omniboost extreme     # Engage Extreme Performance profile
omniboost balanced    # Engage Balanced Adaptive profile
omniboost powersave   # Engage Powersave / Silent profile
omniboost status      # Output hardware discovery & telemetry summary
omniboost monitor     # Launch real-time telemetry dashboard
```

---

## License
MIT License. See [LICENSE](LICENSE) for details.
