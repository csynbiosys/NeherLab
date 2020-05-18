
function [findate] = GetDateJson_Tested (dat)

year = dat(2:5);
monthB = dat(7:8);
day = dat(end-1:end);
month = [];
switch monthB
    case '01'
        month = 'Jan';
    case '02'
        month = 'Feb';
    case '03'
        month = 'Mar';
    case '04'
        month = 'Apr';
    case '05'
        month = 'May';
    case '06'
        month = 'Jun';
    case '07'
        month = 'Jul';
    case '08'
        month = 'Aug';
    case '09'
        month = 'Sep';
    case '10'
        month = 'Oct';
    case '11'
        month = 'Nov';
    case '12'
        month = 'Dec';
end


findate = [day,'-',month,'-',year];



end




















































