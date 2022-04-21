clear all 
clc
l=1;
m=16;  % ask , psk , qam in m=16 constellation
data=randint(1,1000); 
for i=1:1000/4    % 4 bits symbols
    for j=1:4
        data_k(i,j)=data(l);
        l=l+1;
    end
end
symbol=bi2de(data_k,'left-msb'); %% binery to decimal transform

% define ask,psk,qam modems
h1=modem.pammod('m',16,'SymbolOrder','gray');
h2=modem.pamdemod('m',16,'SymbolOrder','gray');

g1=modem.pskmod('m',16,'SymbolOrder','gray');
g2=modem.pskdemod('m',16,'SymbolOrder','gray');

q1=modem.qammod('m',16,'SymbolOrder','Gray');
q2=modem.qamdemod('m',16,'SymbolOrder','Gray');


% modulate signal
    symbol_mod_ask=modulate(h1,symbol);
    symbol_mod_psk=modulate(g1,symbol);
    symbol_mod_qam=modulate(q1,symbol);
    
    
    % various snr for awgn channels
    for snr=1:40
        c=awgn(symbol_mod_ask,snr);
        d=awgn(symbol_mod_psk,snr);
        f=awgn(symbol_mod_qam,snr);
        
       % at reciever
       %signal demodulation
       symbol_demod_psk=demodulate(g2,d);
       symbol_demod_qam=demodulate(q2,f);
       symbol_demod_ask=demodulate(h2,c);
       
       % decimal symbols to binery transform
       demod_bit_ask=de2bi(symbol_demod_ask,'left-msb');
       demod_bit_psk=de2bi(symbol_demod_psk,'left-msb');
       demod_bit_qam=de2bi(symbol_demod_qam,'left-msb');
       % reshape binery matrice to vector 1*1000
       v=1;
        for i=1:250
            for j=1:4
                demod_bit_re_ask(1,v)=demod_bit_ask(i,j);
                demod_bit_re_psk(1,v)=demod_bit_psk(i,j);
                demod_bit_re_qam(1,v)=demod_bit_qam(i,j);
                
                
                v=v+1;
            end
        end
        % bit error rate
        [a b]=biterr(demod_bit_re_ask,data);
        [p q]=biterr(demod_bit_re_psk,data);
        [w z]=biterr(demod_bit_re_qam,data);
        
        % bit error rate vector for various snr
        aerr(snr)=a;
        perr(snr)=p;
        werr(snr)=w;
        
    end
    
        % plot snr vs BER
        close all
        figure
        snr=1:40;
        semilogy(snr,aerr,'mx-')
       grid on
        hold on
        semilogy(snr,perr,'*-')
        hold on
        semilogy(snr,werr,'^-')   
        title('error probability for modulations')
        xlabel('snr   dB')
        ylabel('BER')
        legend('ask','psk','qam')
        
 

        
    


