package org.manager.domain;

public class PageUtil {
public static boolean hasNext(int pageNum, int total) {
        
        int end = getEnd(pageNum, total);
        
        return end * 10 < total; 
    }
    
    public static boolean hasBefore(int pageNum) {
        
        return getStart(pageNum) != 1;
        
    }
    
    
    public static int getEnd(int pageNum, int total) {
        
        if(pageNum <= 0) {
            return 1;
        }
        double temp = Math.ceil(pageNum/ 10.0) * 10;
        
        if(temp * 10>total) {
            temp = Math.ceil(total/10.0);
        }
        
        return(int)temp;
        
    }
    
    public static int getStart(int pageNum) {
        
        if(pageNum <= 0) {
            return 1;
        }
        
        
        int temp = (pageNum -1) / 10;
        
        return (temp * 10) +1; 
    }
}
