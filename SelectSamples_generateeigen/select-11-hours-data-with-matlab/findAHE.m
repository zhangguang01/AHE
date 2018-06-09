function [AHEdata] = findAHE( inputdata,ForecastWin,Win,VAL,TOL)
%------------------------������˵��-------------------%
%������Ĺ���Ϊ���ռ��Ե�Ѫѹ�Ķ��壺Ԥ�ⴰ���ڣ�1��Сʱ�����ڸ�����ÿ����
%����һ�εĶ���ƽ��ѹֵ��������30���ӻ������ʱ����ڣ��г���90%��Ѫѹֵ
%����60mmHgʱ����Ϊ�û��߳����˼��Ե�Ѫѹ��
%
%�����ж����ݳ��ȣ�
%       �����ݳ��Ȳ���ʮһСʱʱ����¼��ǰ��ţ������ʾ�����ݳ��Ȳ��㣻
%       �����ݳ��ȳ���ʮһСʱʱ���ӵ�ʮ��Сʱ֮��ĵ㿪ʼ�ж��Ƿ�ᷢ��AHE       
%       �ص�����Ϊ10min������11��Сʱ���ȵ����ݶΣ��ص�����Ϊ10min�����ƶ�
%
% ���������
%       AHEdata�����1��Сʱ�����˼��Ե�Ѫѹ�Ĺ�11(��3)Сʱ������
%
%���������
%       inputdata�����ж����ݶ�
%       ForcastWin��Ԥ�ⴰ�ڵĳ��ȣ�1��Сʱ��������60��
%       Win:��С���ƶ����ڵĳ��ȣ����Сʱ������21��
%       VAL��������ѪѹʱѪѹֵ�������ֵ��60mmHg������60��
%       TOL��Win��Ѫѹֵ����VAL�ĸ���ռ�������ڵı���������0.9��

lenN=length(inputdata(:,4));%��һ���ж�����
AHEdata=[];

if lenN>=660
    forelen=0;%���ٱ�֤Ԥ�ⴰ��֮ǰ��10��Сʱ�����ݣ�10*60=600
        for iniwin=1:1:(lenN-660+1)%11Сʱ���ڵ���ʼλ��
            X_input=inputdata(iniwin:iniwin+659,1:7);%11Сʱ�ĳ��ȣ�660
            %ABPMean���1Сʱ�Ŀ�ֵֵ����6��ʱ�������ö�����
            zero_len=length(find(X_input(601:660,4)<=0));
            
            loss=[];
            loss_50=[];
            for i=1:7
               loss(1,i)=length(find(X_input(1:600,i)<=0));%ͳ��ȱʧֵ�ĸ���
               loss_50(1,i)=(loss(1,i)>180);%ͳ�Ƹ�����ȱʧ�����Ƿ񳬹�30%����Ϊ1  
            end
            loss_num=sum(loss_50);
            
            if zero_len >= 6 | loss_num > 0
               continue; 
            else
                [ ahe_find] = AHEEpisode( X_input(601:660,4),Win,VAL,TOL );
                if ahe_find==1
                   AHEdata=X_input;
                   break;
                else
                    AHEdata=[];
                end
            end                        
        end        
else
    AHEdata=[];
end


end
