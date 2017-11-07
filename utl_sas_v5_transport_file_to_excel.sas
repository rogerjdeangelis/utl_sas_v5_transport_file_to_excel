Reading and writing  V5 SAS transport files and sas7bdats

   PERL Module

      SAS::TRX  (V5 transport)
      Spreadshee::WriteExcel
      Excel::Writer::XLSX

   R Packages)

     SASxport           (V5 transport)
     haven (read.sas)   (sas7bdats)
     haven (write.sas)  ** under development
     XLConnect, xlsx    excel

   Python

     xport 2.0.2          (V5 transport)
     SAS7BDAT             (sas7bdats)
     XlsWriter, openpyxl   excel

 NOTE ON PERL
 Perl module  SAS::TRX  appears to be able to read a V5 SAS xport file.
 I was able to get the meta data but not the individual records,
 probably because of my lack of understanding
 of Perl Hashes. see end of this message.


see
https://goo.gl/ucaAiD
https://communities.sas.com/t5/Clinical-Development-with-SAS/XPT-to-Excel-Convertor-using-Perl/m-p/411067

see
https://metacpan.org/pod/SAS::TRX

*____
|  _ \
| |_) |
|  _ <
|_| \_\

;

  INPUT V5 transport file in d:/xpt/have.xpt
  ===========================================

     d:/xpt/have.xpt

     Data Set Name        D:/XPT/HAVE.XPT           Observations          .
     Member Type          XPT                       Variables             3
     Engine               XPORT                     Indexes               0
     Created              11/07/2017 14:48:42       Observation Length    24
     Last Modified        11/07/2017 14:48:42       Deleted Observations  0
     Protection                                     Compressed            NO
     Data Set Type                                  Sorted                NO
     Label
     Data Representation  Default
     Encoding             Default

     #    Variable    Type    Len

     1    NAME        Char      8
     2    SEX         Char      1
     3    AGE         Num       8
     4    HEIGHT      Num       8
     5    WEIGHT      Num       8

   WORKING CODE
   ============
   R
      have<-read.xport("d:/xpt/have.xpt");
      wb <- loadWorkbook("d:/xls/have.xlsx", create = TRUE);
      createSheet(wb, name = "have");
      writeWorksheet(wb, have, sheet = "have");

   OUTPUT
   ======

     D:/XLS/HAVE.XLSX

        +----------------------------------------------------------------+
        |     A      |    B       |     C      |    D       |    E       |
        +----------------------------------------------------------------+
     1  | NAME       |   SEX      |    AGE     |  HEIGHT    |  WEIGHT    |
        +------------+------------+------------+------------+------------+
     2  | ALFRED     |    M       |    14      |    69      |  112.5     |
        +------------+------------+------------+------------+------------+
         ...
        +------------+------------+------------+------------+------------+
     20 | WILLIAM    |    M       |    15      |   66.5     |  112       |
        +------------+------------+------------+------------+------------+


*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

options validvarname=upcase;  /* need this because R is case sensitive */
libname xpt xport "d:/xpt/have.xpt";
data xpt.have;
  set sashelp.class;
run;quit;
libname xpt clear;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%utl_submit_r64('
   source("c:/Program Files/R/R-3.3.2/etc/Rprofile.site",echo=T);
   library(SASxport);
   library(XLConnect);
   have<-read.xport("d:/xpt/have.xpt");
   wb <- loadWorkbook("d:/xls/have.xlsx", create = TRUE);
   createSheet(wb, name = "have");
   writeWorksheet(wb, have, sheet = "have");
   saveWorkbook(wb);
');

*____  _____ ____  _
|  _ \| ____|  _ \| |
| |_) |  _| | |_) | |
|  __/| |___|  _ <| |___
|_|   |_____|_| \_\_____|

;


%utl_submit_pl64('
   #!c:/perl/bin/perl -w
    use strict;`
    use warnings;`
    use base SAS::TRX;`
    use Data::Dumper qw(Dumper);`
    my $trx = new SAS::TRX;`
    $trx->load("d:/xpt/have.xpt");`
    print Dumper(\%$trx);`
');


OUTPUT

$VAR1 = bless( {
  'NSTR_LEN' => '140',
  'LIB' => 'SASLIB',
  'TRX' => {
       'HAVE' => {
           'CNAMES' => [
                         'NAME',
                         'SEX',
                         'AGE',
                         'HEIGHT',
                         'WEIGHT'
                       ],
           'DSLABEL' => '',
           'CTYPES' => [
                         2,
                         2,
                         1,
                         1,
                         1
                       ],
           'VAR' => [
                      {
                        'NIFL' => 0,
                        'NIFD' => 0,
                        'NIFORM' => '',
                        'NFORM' => '',
                        'NHFUN' => 0,
                        'REST' => '',
                        'NFJ' => 0,
                        'NVAR0' => 1,
                        'NLNG' => 8,
                        'NLABEL' => '',
                        'NPOS' => 0,
                        'NNAME' => 'NAME',
                        'NFL' => 0,
                        'NFILL' => '',
                        'NFD' => 0,
                        'NTYPE' => 2
                      },
                      {
                        'NIFL' => 0,
                        'NIFD' => 0,
                        'NIFORM' => '',
                        'NFORM' => '',
                        'NHFUN' => 0,
                        'REST' => '',
                        'NFJ' => 0,
                        'NVAR0' => 2,
                        'NLNG' => 1,
                        'NLABEL' => '',
                        'NPOS' => 8,
                        'NNAME' => 'SEX',
                        'NFL' => 0,
                        'NFILL' => '',
                        'NFD' => 0,
                        'NTYPE' => 2
                      },
                      {
                        'NIFL' => 0,
                        'NIFD' => 0,
                        'NIFORM' => '',
                        'NFORM' => '',
                        'NHFUN' => 0,
                        'REST' => '',
                        'NFJ' => 0,
                        'NVAR0' => 3,
                        'NLNG' => 8,
                        'NLABEL' => '',
                        'NPOS' => 9,
                        'NNAME' => 'AGE',
                        'NFL' => 0,
                        'NFILL' => '',
                        'NFD' => 0,
                        'NTYPE' => 1
                      },
                      {
                        'NIFL' => 0,
                        'NIFD' => 0,
                        'NIFORM' => '',
                        'NFORM' => '',
                        'NHFUN' => 0,
                        'REST' => '',
                        'NFJ' => 0,
                        'NVAR0' => 4,
                        'NLNG' => 8,
                        'NLABEL' => '',
                        'NPOS' => 17,
                        'NNAME' => 'HEIGHT',
                        'NFL' => 0,
                        'NFILL' => '',
                        'NFD' => 0,
                        'NTYPE' => 1
                      },
                      {
                        'NIFL' => 0,
                        'NIFD' => 0,
                        'NIFORM' => '',
                        'NFORM' => '',
                        'NHFUN' => 0,
                        'REST' => '',
                        'NFJ' => 0,
                        'NVAR0' => 5,
                        'NLNG' => 8,
                        'NLABEL' => '',
                        'NPOS' => 25,
                        'NNAME' => 'WEIGHT',
                        'NFL' => 0,
                        'NFILL' => '',
                        'NFD' => 0,
                        'NTYPE' => 1
                      }
                    ],
           'DSTYPE' => ''
         }
     },
  'FH' => bless( \*Symbol::GEN0, 'IO::File' ),
  'VER' => '9.4'
}, 'SAS::TRX' );

