package com.hfxt;

import static org.junit.Assert.assertTrue;

import com.hfxt.dao.IUserDao;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Unit test for simple App.
 */
public class AppTest
{

    /**
     * Rigorous Test :-)
     */
    @Test
    public void shouldAnswerWithTrue()
    {

        int num = 17;

        while(num>0){

            System.out.print(num ++ %5 + "\t");

            num /=5;

        }
        assertTrue( true );
    }
}
