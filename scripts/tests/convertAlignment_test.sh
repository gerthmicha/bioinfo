#!/bin/bash
# #!/bin/bash -x

TempID=$$
ScriptDir=..
ScriptName=convertAlignment.pl

# Complete set of variables used in tests; reset between tests

function ClearVariables()
{
    ThisTest=
    Input=
    CompressedInput=
    Expected=
    Output=
    Temp1=
    Temp2=
    Temp3=
}
ClearVariables

function RemoveTempFiles()
{
    rm -f $Temp1 $Temp2
    if [ "$Temp3" != "" ] ; then
        rm -f $Temp3
    fi
}
RemoveTempFiles


# -------------------------------- convertAlignment_test_01


ThisTest="convertAlignment_test_01"
echo -n $ThisTest - general test of script operation 
Input=${ThisTest}.input
if [ "$CompressedInput" != "" -a ! -f $Input ] ; then
    gzip -d -c < $CompressedInput > $Input
fi
Options=${ThisTest}.options
Expected=${ThisTest}.expected
Temp1=$ThisTest.$TempID.1
Temp2=$ThisTest.$TempID.2
$ScriptDir/$ScriptName $(< $Options) > $Temp1
if diff $Temp1 $Expected ; then
    echo " - PASSED"
    RemoveTempFiles
    if [ "$CompressedInput" != "" ] ; then
        rm -f $Input
    fi
else
    echo " - FAILED"
fi
ClearVariables

