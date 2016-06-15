package cms.utils;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;

import org.apache.log4j.Logger;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * 图片水印,文字水印,缩放,补白等
 */
public final class ImageUtil {
    private static Logger log = Logger.getLogger(ImageUtil.class);
    /**
     * 图片格式:JPG
     */
    private static final String PICTRUE_FORMATE_JPG = "jpg";

    private ImageUtil() {
    }

    /**
     * 添加图片水印
     *
     * @param targetImg 目标图片路径,如:C://myPictrue//1.jpg
     * @param waterImg  水印图片路径,如:C://myPictrue//logo.png
     * @param x         水印图片距离目标图片左侧的偏移量,如果x<0,则在正中间
     * @param y         水印图片距离目标图片上侧的偏移量,如果y<0,则在正中间
     * @param alpha     透明度(0.0 -- 1.0,0.0为完全透明,1.0为完全不透明)
     */
    public final static void pressImage(String targetImg, String waterImg, int x, int y, float alpha) {
        try {
            File file = new File(targetImg);
            Image image = ImageIO.read(file);
            int width = image.getWidth(null);
            int height = image.getHeight(null);
            BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = bufferedImage.createGraphics();
            g.drawImage(image, 0, 0, width, height, null);

            // 水印文件
            Image waterImage = ImageIO.read(new File(waterImg));
            int width_1 = waterImage.getWidth(null);
            int height_1 = waterImage.getHeight(null);
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));

            int widthDiff = width - width_1;
            int heightDiff = height - height_1;
            if (x < 0) {
                x = widthDiff / 2;
            } else if (x > widthDiff) {
                x = widthDiff;
            }
            if (y < 0) {
                y = heightDiff / 2;
            } else if (y > heightDiff) {
                y = heightDiff;
            }
            g.drawImage(waterImage, x, y, width_1, height_1, null); // 水印文件结束
            g.dispose();
            ImageIO.write(bufferedImage, PICTRUE_FORMATE_JPG, file);
        } catch (IOException e) {
            log.error("图片添加图片水印错误", e);
        }
    }

    /**
     * 添加文字水印
     *
     * @param targetImg 目标图片路径,如:C://myPictrue//1.jpg
     * @param pressText 水印文字,如:中国证券网
     * @param fontName  字体名称,如:宋体
     * @param fontStyle 字体样式,如:粗体和斜体(Font.BOLD|Font.ITALIC)
     * @param fontSize  字体大小,单位为像素
     * @param color     字体颜色
     * @param x         水印文字距离目标图片左侧的偏移量,如果x<0,则在正中间
     * @param y         水印文字距离目标图片上侧的偏移量,如果y<0,则在正中间
     * @param alpha     透明度(0.0 -- 1.0,0.0为完全透明,1.0为完全不透明)
     * @param position  0左上 1左下 2右上 3右下
     * @param qualNum   图片质量
     */
    public static void pressText(String targetImg, String pressText,
                                 String fontName, int fontStyle, int fontSize, Color color, int x,
                                 int y, float alpha, int position, float qualNum) {
        try {
            File file = new File(targetImg);
            Image image = ImageIO.read(file);
            int width = image.getWidth(null);
            int height = image.getHeight(null);
            int width_1 = fontSize * getLength(pressText);
            int height_1 = fontSize;
            if (width >= x + width_1 && height > y + height_1) {
                BufferedImage bufferedImage = new BufferedImage(width, height,
                        BufferedImage.TYPE_INT_RGB);
                Graphics2D g = bufferedImage.createGraphics();
                g.drawImage(image, 0, 0, width, height, null);
                g.setFont(new Font(fontName, fontStyle, fontSize));
                g.setColor(color);
                g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));


                int widthDiff = width - width_1;
                int heightDiff = height - height_1;
                if (x < 0) {
                    x = widthDiff / 2;
                } else if (position == 2) {
                    x = widthDiff - x;
                } else if (position == 3) {
                    x = widthDiff - x;
                }

                if (y < 0) {
                    y = heightDiff / 2;
                } else if (position == 0) {
                    y = height_1 - 6;
                } else if (position == 1) {
                    y = heightDiff - y + height_1 - 1;
                } else if (position == 2) {
                    y = height_1 - 6;
                } else if (position == 3) {
                    y = heightDiff - y + height_1 - 1;
                }

                g.drawString(pressText, x, y);
                g.dispose();
                //ImageIO.write(bufferedImage,PICTRUE_FORMATE_JPG,file);
                FileOutputStream out = new FileOutputStream(targetImg);
                JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
                JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(bufferedImage);
                param.setQuality(qualNum, true);
                encoder.encode(bufferedImage, param);
                out.close();
            }
        } catch (Exception e) {
            log.error("图片添加文字水印错误", e);
        }
    }

    /**
     * 获取字符长度,一个汉字作为1个字符,一个英文字母作为0.5个字符
     */
    public static int getLength(String text) {
        int textLength = text.length();
        int length = textLength;
        for (int i = 0; i < textLength; i++) {
            if (String.valueOf(text.charAt(i)).getBytes().length > 1) {
                length++;
            }
        }
        return (length % 2 == 0) ? length / 2 : length / 2 + 1;
    }

    /**
     * 图片缩放
     *
     * @param filePath 图片路径
     * @param height   高度
     * @param width    宽度
     * @param bb       比例不对时是否需要补白
     */
    public static void resize(String filePath, int height, int width, boolean bb) {
        try {
            // 缩放比例
            double ratio = 0;
            File f = new File(filePath);
            BufferedImage bi = ImageIO.read(f);
            Image itemp = bi.getScaledInstance(width, height,
                    BufferedImage.SCALE_SMOOTH);

            // 计算比例
            if ((bi.getHeight() > height) || (bi.getWidth() > width)) {
                if (bi.getHeight() > bi.getWidth()) {
                    ratio = (new Integer(height)).doubleValue()
                            / bi.getHeight();
                } else {
                    ratio = (new Integer(width)).doubleValue() / bi.getWidth();
                }
                AffineTransformOp op = new AffineTransformOp(
                        AffineTransform.getScaleInstance(ratio, ratio), null);
                itemp = op.filter(bi, null);
            }
            if (bb) {
                BufferedImage image = new BufferedImage(width, height,
                        BufferedImage.TYPE_INT_RGB);
                Graphics2D g = image.createGraphics();
                g.setColor(Color.white);
                g.fillRect(0, 0, width, height);
                if (width == itemp.getWidth(null))
                    g.drawImage(itemp, 0, (height - itemp.getHeight(null)) / 2,
                            itemp.getWidth(null), itemp.getHeight(null),
                            Color.white, null);
                else
                    g.drawImage(itemp, (width - itemp.getWidth(null)) / 2, 0,
                            itemp.getWidth(null), itemp.getHeight(null),
                            Color.white, null);
                g.dispose();
                itemp = image;
            }
            ImageIO.write((BufferedImage) itemp, "jpg", f);
        } catch (IOException e) {
            log.error("图片缩放错误", e);
        }
    }

    public static void main(String[] args) throws IOException {
        // pressImage("C://pic//jpg","C://pic//test.gif",5000,5000,0f);
        pressText("E://QQ.jpg", "www.devnote.cn", "Times New Romas",
                Font.PLAIN, 22, Color.BLUE, 10, 20, 1f, 3, 70f);
        // resize("E://Tulips.jpg",200,100,true);
    }
}