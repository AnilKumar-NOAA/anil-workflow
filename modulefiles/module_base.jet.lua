help([[
Load environment to run GFS on Jet
]])

prepend_path("MODULEPATH", "/lfs4/HFIP/hfv3gfs/role.epic/hpc-stack/libs/intel-18.0.5.274/modulefiles/stack")

load(pathJoin("hpc", os.getenv("hpc_ver")))
load(pathJoin("hpc-intel", os.getenv("hpc_intel_ver")))
load(pathJoin("hpc-impi", os.getenv("hpc_impi_ver")))

load("hpss")
load(pathJoin("gempak", os.getenv("gempak_ver")))
load(pathJoin("ncl", os.getenv("ncl_ver")))
load(pathJoin("jasper", os.getenv("jasper_ver")))
load(pathJoin("libpng", os.getenv("libpng_ver")))
load(pathJoin("cdo", os.getenv("cdo_ver")))
load(pathJoin("R", os.getenv("R_ver")))

load(pathJoin("hdf5", os.getenv("hdf5_ver")))
load(pathJoin("netcdf", os.getenv("netcdf_ver")))

load(pathJoin("nco", os.getenv("nco_ver")))
load(pathJoin("prod_util", os.getenv("prod_util_ver")))
load(pathJoin("grib_util", os.getenv("grib_util_ver")))
load(pathJoin("g2tmpl", os.getenv("g2tmpl_ver")))
load(pathJoin("ncdiag", os.getenv("ncdiag_ver")))
load(pathJoin("crtm", os.getenv("crtm_ver")))
load(pathJoin("wgrib2", os.getenv("wgrib2_ver")))

prepend_path("MODULEPATH", "/contrib/anaconda/modulefiles")
load(pathJoin("anaconda", os.getenv("anaconda_ver")))

--prepend_path("MODULEPATH", pathJoin("/lfs4/HFIP/hfv3gfs/glopara/git/prepobs/v" .. os.getenv("prepobs_run_ver"), "modulefiles"))
prepend_path("MODULEPATH", pathJoin("/lfs4/HFIP/hfv3gfs/glopara/git/prepobs/feature-GFSv17_com_reorg_log_update/modulefiles"))
load(pathJoin("prepobs", os.getenv("prepobs_run_ver")))

prepend_path("MODULEPATH", pathJoin("/lfs4/HFIP/hfv3gfs/glopara/git/Fit2Obs/v" .. os.getenv("fit2obs_ver"), "modulefiles"))
load(pathJoin("fit2obs", os.getenv("fit2obs_ver")))

whatis("Description: GFS run environment")
