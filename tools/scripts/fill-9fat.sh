# To be run by the shell in the hosted Inferno environment.

dossrv -f fsdisk/9fat.part
echo 'bootfile=sdC0!9fat!ipc.gz' > plan9.ini
cp fsdisk/9fat/9load fsdisk/9fat/ipc.gz fsdisk/9fat/plan9.ini /n/dos/
unmount /n/dos
echo '9fat written.'
