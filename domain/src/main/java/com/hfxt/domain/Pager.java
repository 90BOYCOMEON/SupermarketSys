package com.hfxt.domain;

public class Pager {

    private Integer currentPage = 1;
    private Integer pageSize = 20;
    private Integer totalPage = 1;
    private Integer totalCount;

    private Integer startPage;

    public Integer getStartPage() {
        return (currentPage-1)*pageSize;
    }

    public void setStartPage(Integer startPage) {
        this.startPage = startPage;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getTotalPage() {
        return totalCount % pageSize == 0 ? totalCount / pageSize : totalCount / pageSize + 1;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }
}
