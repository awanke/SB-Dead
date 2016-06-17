import cms.po.Catalog;
import cms.utils.FastJsonUtil;
import cms.utils.TreeUtil;
import org.junit.Test;

import java.util.LinkedList;
import java.util.List;

public class TreeUtilTest {

    @Test
    public void test() {
        List<Catalog> list = new LinkedList<Catalog>();

        Catalog c1 = new Catalog();
        c1.setId(1);
        c1.setFolder("0");
        c1.setDeep(1);
        c1.setName("java");

        Catalog c2 = new Catalog();
        c2.setId(2);
        c2.setFolder("0");
        c2.setDeep(1);
        c2.setName("c++");

        Catalog c3 = new Catalog();
        c3.setId(3);
        c3.setFolder("2");
        c3.setDeep(2);
        c3.setName("hadoop");

        Catalog c4 = new Catalog();
        c4.setId(4);
        c4.setFolder("3");
        c4.setDeep(3);
        c4.setName("solr");

        list.add(c1);
        list.add(c2);
        list.add(c3);
        list.add(c4);

        System.out.println(FastJsonUtil.getJson(TreeUtil.baseTreeNode(TreeUtil.catalog2TreeNode(list))));
    }
}
