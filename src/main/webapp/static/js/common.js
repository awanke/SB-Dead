/**
 * 设置/取消 全选
 * @param selectall 触发事件的checkbox id
 * @param ids 需要设置值的checkbox name
 */
function selectAll(selectall, ids) {
    var selectall = document.getElementById(selectall);
    var checkboxes = document.getElementsByName(ids);

    for (var i = 0; i < checkboxes.length; i++) {
        if (selectall.checked) {
            checkboxes[i].checked = true;
        } else {
            checkboxes[i].checked = false;
        }
    }
}

/**
 * 批量操作，删除或者其他
 * @param name id所在的checkbox的name
 * @param url 删除使用的请求地址，如：${ctx}/article/delete?ids=
 */
function doBatch(name, url) {
    var tagbox = document.getElementsByName(name);
    var valueArray = new Array();
    var num = 0;
    for (var i = 0; i < tagbox.length; i++) {
        if (tagbox[i].checked) {
            valueArray[num] = tagbox[i].value;
            num++;
        }
    }
    if (num < 1) {
        alert("请选择需要操作的数据");
    } else if (window.confirm("确定执行么？")) {
        window.location.href = url + valueArray.join(',');
    }
}

/**
 * 将所有中文逗号自动更换成英文逗号
 */
function replaceChineseComma(e) {
    e.value = e.value.replace(/，/g, ",");
}