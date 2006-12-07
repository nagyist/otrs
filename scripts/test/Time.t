# --
# Time.t - Time tests
# Copyright (C) 2001-2006 OTRS GmbH, http://otrs.org/
# --
# $Id: Time.t,v 1.8 2006-12-07 08:07:42 martin Exp $
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see http://www.gnu.org/licenses/gpl.txt.
# --

use Kernel::System::Time;

$Self->{TimeObject} = Kernel::System::Time->new(%{$Self});

my $SystemTime = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-20 10:00:00',
);
$Self->Is(
    $SystemTime,
    1129795200,
    'TimeStamp2SystemTime()',
);

my ($Sec, $Min, $Hour, $Day, $Month, $Year) = $Self->{TimeObject}->SystemTime2Date(
    SystemTime => $SystemTime,
);
$Self->Is(
    "$Year-$Month-$Day $Hour:$Min:$Sec",
    '2005-10-20 10:00:00',
    'SystemTime2Date()',
);

my $SystemTimeUnix = $Self->{TimeObject}->Date2SystemTime(
    Year => 2005,
    Month => 10,
    Day => 20,
    Hour => 10,
    Minute => 0,
    Second => 0,
);
$Self->Is(
    $SystemTime,
    $SystemTimeUnix,
    'Date2SystemTime()',
);

my $SystemTime2 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-21 10:00:00',
);
my $SystemTime3 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-24 10:00:00',
);
my $SystemTime4 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-27 10:00:00',
);
my $SystemTime5 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-11-03 10:00:00',
);
my $SystemTime6 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-12-21 10:00:00',
);
my $SystemTime7 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-12-31 10:00:00',
);
my $SystemTime8 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2003-12-21 10:00:00',
);
my $SystemTime9 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2003-12-31 10:00:00',
);
my $SystemTime10 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-23 10:00:00',
);
my $SystemTime11 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-24 10:00:00',
);
my $SystemTime12 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-23 10:00:00',
);
my $SystemTime13 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-25 13:00:00',
);
my $SystemTime14 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-23 10:00:00',
);
my $SystemTime15 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-30 13:00:00',
);
my $SystemTime16 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-24 11:44:12',
);
my $SystemTime17 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2005-10-24 16:13:31',
);
my $SystemTime18 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-12-05 22:57:34',
);
my $SystemTime19 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-12-06 10:25:34',
);
my $SystemTime20 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-12-06 07:50:00',
);
my $SystemTime21 = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-12-07 08:54:00',
);
my $WorkingTime = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime,
    StopTime => $SystemTime2,
);
my $WorkingTime2 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime,
    StopTime => $SystemTime3,
);
my $WorkingTime3 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime,
    StopTime => $SystemTime4,
);
my $WorkingTime4 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime,
    StopTime => $SystemTime5,
);
my $WorkingTime5 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime6,
    StopTime => $SystemTime7,
);
my $WorkingTime6 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime8,
    StopTime => $SystemTime9,
);
my $WorkingTime7 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime10,
    StopTime => $SystemTime11,
);
my $WorkingTime8 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime12,
    StopTime => $SystemTime13,
);
my $WorkingTime9 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime14,
    StopTime => $SystemTime15,
);
my $WorkingTime10 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime16,
    StopTime => $SystemTime17,
);
my $WorkingTime11 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime18,
    StopTime => $SystemTime19,
);
my $WorkingTime12 = $Self->{TimeObject}->WorkingTime(
    StartTime => $SystemTime20,
    StopTime => $SystemTime21,
);

$Self->Is(
    $WorkingTime/60/60,
    13,
    'WorkingHours - Thu-Fri',
);

$Self->Is(
    $WorkingTime2/60/60,
    26,
    'WorkingHours - Thu-Mon',
);

$Self->Is(
    $WorkingTime3/60/60,
    65,
    'WorkingHours - Thu-Thu',
);

$Self->Is(
    $WorkingTime4/60/60,
    130,
    'WorkingHours - Thu-Thu-Thu',
);

$Self->Is(
    $WorkingTime5/60/60,
    89,
    'WorkingHours - Fri-Fri-Mon',
);

$Self->Is(
    $WorkingTime6/60/60,
    52,
    'WorkingHours - The-The-Fr',
);

$Self->Is(
    $WorkingTime7/60/60,
    2,
    'WorkingHours - Sun-Mon',
);

$Self->Is(
    $WorkingTime8/60/60,
    18,
    'WorkingHours - Son-The',
);

$Self->Is(
    $WorkingTime9/60/60,
    65,
    'WorkingHours - Son-Son',
);

$Self->Is(
    $WorkingTime10/60/60,
    4.48333333333333,
    'WorkingHours - Mon-Mon',
);
$Self->Is(
    $WorkingTime11/60/60,
    2.41666666666667,
    'WorkingHours - Thu-Wed',
);
$Self->Is(
    $WorkingTime12/60/60,
    13.9,
    'WorkingHours - Thu-Wed',
);

my $SystemTimeDestination = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-11-12 10:15:00',
);
my $DestinationTime = $Self->{TimeObject}->DestinationTime(
    StartTime => $SystemTimeDestination,
    Time => 60*60*4,
);
($Sec, $Min, $Hour, $Day, $Month, $Year) = $Self->{TimeObject}->SystemTime2Date(
    SystemTime => $DestinationTime,
);
$Self->Is(
    "$Year-$Month-$Day $Hour:$Min:$Sec",
    '2006-11-13 11:00:00',
    'DestinationTime()',
);

$SystemTimeDestination = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-11-13 10:15:00',
);
$DestinationTime = $Self->{TimeObject}->DestinationTime(
    StartTime => $SystemTimeDestination,
    Time => 60*60*4,
);
($Sec, $Min, $Hour, $Day, $Month, $Year) = $Self->{TimeObject}->SystemTime2Date(
    SystemTime => $DestinationTime,
);
$Self->Is(
    "$Year-$Month-$Day $Hour:$Min:$Sec",
    '2006-11-13 14:15:00',
    'DestinationTime()',
);

$SystemTimeDestination = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-11-13 10:15:00',
);
$DestinationTime = $Self->{TimeObject}->DestinationTime(
    StartTime => $SystemTimeDestination,
    Time => 60*60*11,
);
($Sec, $Min, $Hour, $Day, $Month, $Year) = $Self->{TimeObject}->SystemTime2Date(
    SystemTime => $DestinationTime,
);
$Self->Is(
    "$Year-$Month-$Day $Hour:$Min:$Sec",
    '2006-11-14 08:15:00',
    'DestinationTime()',
);

$SystemTimeDestination = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-12-31 10:15:00',
);
$DestinationTime = $Self->{TimeObject}->DestinationTime(
    StartTime => $SystemTimeDestination,
    Time => 60*60*11,
);
($Sec, $Min, $Hour, $Day, $Month, $Year) = $Self->{TimeObject}->SystemTime2Date(
    SystemTime => $DestinationTime,
);
$Self->Is(
    "$Year-$Month-$Day $Hour:$Min:$Sec",
    '2007-01-02 18:00:00',
    'DestinationTime()',
);

$SystemTimeDestination = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-12-29 10:15:00',
);
$DestinationTime = $Self->{TimeObject}->DestinationTime(
    StartTime => $SystemTimeDestination,
    Time => 60*60*11,
);
($Sec, $Min, $Hour, $Day, $Month, $Year) = $Self->{TimeObject}->SystemTime2Date(
    SystemTime => $DestinationTime,
);
$Self->Is(
    "$Year-$Month-$Day $Hour:$Min:$Sec",
    '2007-01-02 08:15:00',
    'DestinationTime()',
);

$SystemTimeDestination = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-12-30 10:45:00',
);
$DestinationTime = $Self->{TimeObject}->DestinationTime(
    StartTime => $SystemTimeDestination,
    Time => 60*60*11,
);
($Sec, $Min, $Hour, $Day, $Month, $Year) = $Self->{TimeObject}->SystemTime2Date(
    SystemTime => $DestinationTime,
);
$Self->Is(
    "$Year-$Month-$Day $Hour:$Min:$Sec",
    '2007-01-02 18:00:00',
    'DestinationTime()',
);

$SystemTimeDestination = $Self->{TimeObject}->TimeStamp2SystemTime(
    String => '2006-12-06 07:50:00',
);
$DestinationTime = $Self->{TimeObject}->DestinationTime(
    StartTime => $SystemTimeDestination,
    Time => $WorkingTime12,
);
($Sec, $Min, $Hour, $Day, $Month, $Year) = $Self->{TimeObject}->SystemTime2Date(
    SystemTime => $DestinationTime,
);
$Self->Is(
    "$Year-$Month-$Day $Hour:$Min:$Sec",
    '2006-12-07 08:44:00',
    'DestinationTime()',
);

# check the vacations
my $Vacation = '';

# 2005-01-01
$Vacation = $Self->{TimeObject}->VacationCheck(
    Year  => '2005',
    Month => '1',
    Day   => '1',
);

$Self->Is(
    $Vacation,
    "New Year's Eve!",
    'Vacation - 2005-01-01',
);

# 2005-01-01
$Vacation = $Self->{TimeObject}->VacationCheck(
    Year  => '2005',
    Month => '01',
    Day   => '01',
);

$Self->Is(
    $Vacation,
    "New Year's Eve!",
    'Vacation - 2005-01-01',
);

# 2005-12-31

$Vacation = $Self->{TimeObject}->VacationCheck(
    Year  => '2005',
    Month => '12',
    Day   => '31',
);

$Self->Is(
    $Vacation,
    'Silvester',
    'Vacation - 2005-12-31',
);

1;
