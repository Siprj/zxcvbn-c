import Distribution.Simple
import Distribution.Types.HookedBuildInfo
import Distribution.Simple.Setup
import System.Process


main = defaultMainWithHooks simpleUserHooks
    { preConf = buildCLib
    , preClean = cleanCLib
    }

buildCLib :: Args -> ConfigFlags -> IO HookedBuildInfo
buildCLib _ _ = do
    system "make dict-src.h"
    pure (Nothing, [])

cleanCLib :: Args -> CleanFlags -> IO HookedBuildInfo
cleanCLib _ _ = do
    _ <- system "make clean"
    _ <- system "rm -f dict-src.h" -- clean misses this file
    pure (Nothing, [])
