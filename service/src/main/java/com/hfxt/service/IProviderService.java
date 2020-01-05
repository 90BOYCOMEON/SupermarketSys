package com.hfxt.service;

import com.hfxt.domain.Pager;
import com.hfxt.domain.Provider;

import java.util.List;
import java.util.Map;

public interface IProviderService {

    public Provider getProviderById(Integer id);

    public Provider getProviderByProCode(String proCode);

    public Provider getProviderByProName(String proName);

    public List<Provider> getAllProviderByPage(String proName, Pager pager);

    public String delProviderById(Integer id);

    public String updateProvider(Provider provider);

    public String saveProvider(Provider provider);

    public Map<String,Object> toMap(Provider provider);

}
