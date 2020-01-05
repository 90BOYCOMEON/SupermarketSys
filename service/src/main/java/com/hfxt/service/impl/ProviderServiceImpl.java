package com.hfxt.service.impl;

import com.alibaba.fastjson.JSON;
import com.hfxt.dao.IProviderDao;
import com.hfxt.domain.Pager;
import com.hfxt.domain.Provider;
import com.hfxt.service.IProviderService;
import com.hfxt.utils.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class ProviderServiceImpl implements IProviderService {

    @Autowired
    private IProviderDao providerDao;

    @Autowired
    private RedisUtils redisUtils;


    @Override
    public Provider getProviderById(Integer id) {

        Object o = redisUtils.get(id + "p");
        if(o!=null){
            return JSON.parseObject(o.toString(), Provider.class);
        }
        Provider provider = providerDao.getProviderById(id);
        if(provider==null){
            return null;
        }
        redisUtils.set(id+"p",JSON.toJSON(provider).toString());
        return provider;
    }

    @Override
    public Provider getProviderByProCode(String proCode) {
        Object o = redisUtils.get(proCode+ "p");
        if(o!=null){
            return JSON.parseObject(o.toString(),Provider.class);
        }
        Provider provider = providerDao.getProviderByProCode(proCode);
        if(provider==null){
            return null;
        }
        redisUtils.set(proCode+ "p",JSON.toJSON(provider).toString());
        return provider;
    }

    @Override
    public Provider getProviderByProName(String proName) {
        Object o = redisUtils.get(proName+ "p");
        if(o!=null){
            return JSON.parseObject(o.toString(),Provider.class);
        }
        Provider provider = providerDao.getProviderByProName(proName);
        if(provider==null){
            return null;
        }
        redisUtils.set(proName+ "p",JSON.toJSON(provider).toString());
        return provider;
    }

    @Override
    public List<Provider> getAllProviderByPage(String proName, Pager pager) {
        List<Provider> providerList = providerDao.getAllProviderByPage(proName, pager);
        pager.setTotalCount(providerDao.getCount(proName));
        return providerList;
    }

    @Override
    public String delProviderById(Integer id) {
        boolean exist = redisUtils.exist(id + "p");
        if(exist){
            redisUtils.delete(id+"p");
        }
        Integer row = providerDao.delProviderById(id);
        return row>0?"success":"error";
    }

    @Override
    public String updateProvider(Provider provider) {
        Map<String, Object> map = toMap(provider);
        Integer row = providerDao.updateProvider(map);
        redisUtils.delete(provider.getId()+"p");
        redisUtils.delete(provider.getProCode()+ "p");
        redisUtils.delete(provider.getProName()+ "p");
        Provider p = providerDao.getProviderById(provider.getId());
        redisUtils.delete(p.getProCode()+ "p");
        redisUtils.delete(p.getProName()+ "p");
        redisUtils.set(p.getId()+"p",JSON.toJSON(p).toString());
        redisUtils.set(p.getProCode()+ "p",JSON.toJSON(p).toString());
        redisUtils.set(p.getProName()+ "p",JSON.toJSON(p).toString());
        return row>0?"success":"error";
    }

    @Override
    public String saveProvider(Provider provider) {
        Provider p = providerDao.getProviderByProCode(provider.getProCode());
        if(p!=null){
            return "providerExits";
        }
        Map<String, Object> map = toMap(provider);
        return providerDao.saveProvider(map)>0?"success":"error";
    }

    @Override
    public Map<String, Object> toMap(Provider provider) {

        Map<String,Object> map = new HashMap<>();
        map.put("id",provider.getId());
        map.put("proCode",provider.getProCode());
        map.put("proName",provider.getProName());
        map.put("proDesc",provider.getProDesc());
        map.put("proContact",provider.getProContact());
        map.put("proPhone",provider.getProPhone());
        map.put("proAddress",provider.getProAddress());
        map.put("proFax",provider.getProFax());
        map.put("createdBy",provider.getCreatedBy());
        map.put("creationDate",provider.getCreationDate());
        map.put("modifyDate",provider.getModifyDate());
        map.put("modifyBy",provider.getModifyBy());
        map.put("status",provider.getStatus());
        return map;
    }
}
