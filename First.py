# فایل: convolution_python.py
import ctypes
import numpy as np
from PIL import Image
import time
import os

class ConvolutionASM:
    def __init__(self, asm_lib_path='./libconv.so'):
        """بارگذاری کتابخانه اسمبلی"""
        if not os.path.exists(asm_lib_path):
            raise FileNotFoundError(f"فایل {asm_lib_path} پیدا نشد!")
        
        self.lib = ctypes.CDLL(asm_lib_path)
        
        # تعریف تابع convolve_asm
        self.lib.convolve_asm.argtypes = [
            ctypes.POINTER(ctypes.c_float),  # image
            ctypes.POINTER(ctypes.c_float),  # kernel
            ctypes.POINTER(ctypes.c_float),  # result
            ctypes.c_int,                     # width
            ctypes.c_int,                     # height
            ctypes.c_int                      # kernel_size
        ]
        self.lib.convolve_asm.restype = None
        
        print("✅ کتابخانه اسمبلی با موفقیت بارگذاری شد")
    
    def convolve(self, image, kernel):
        """
        اعمال convolution روی تصویر
        image: آرایه 2 بعدی numpy
        kernel: آرایه 2 بعدی numpy (فیلتر)
        """
        h, w = image.shape
        kh, kw = kernel.shape
        
        if kh != kw:
            raise ValueError("فیلتر باید مربعی باشد!")
        
        # آماده‌سازی داده‌ها
        img_float = image.astype(np.float32)
        kernel_float = kernel.astype(np.float32)
        result = np.zeros((h, w), dtype=np.float32)
        
        # گرفتن اشاره‌گرها
        img_ptr = img_float.ctypes.data_as(ctypes.POINTER(ctypes.c_float))
        kernel_ptr = kernel_float.ctypes.data_as(ctypes.POINTER(ctypes.c_float))
        result_ptr = result.ctypes.data_as(ctypes.POINTER(ctypes.c_float))
        
        # فراخوانی تابع اسمبلی
        self.lib.convolve_asm(img_ptr, kernel_ptr, result_ptr, w, h, kh)
        
        return result
    
    def apply_filter(self, image_path, kernel, output_path=None):
        """اعمال فیلتر روی تصویر از فایل"""
        # بارگذاری تصویر
        img = Image.open(image_path).convert('L')  # خاکستری
        img_array = np.array(img, dtype=np.float32)
        
        # اعمال convolution
        start_time = time.time()
        result = self.convolve(img_array, kernel)
        asm_time = time.time() - start_time
        
        # محدود کردن مقادیر به 0-255
        result = np.clip(result, 0, 255).astype(np.uint8)
        
        # ذخیره نتیجه
        if output_path:
            result_img = Image.fromarray(result)
            result_img.save(output_path)
        
        return result, asm_time

def create_test_filters():
    """ایجاد فیلترهای مختلف برای تست"""
    filters = {
        'Identity': np.array([[0, 0, 0],
                              [0, 1, 0],
                              [0, 0, 0]], dtype=np.float32),
        
        'Edge Detection': np.array([[-1, -1, -1],
                                     [-1, 8, -1],
                                     [-1, -1, -1]], dtype=np.float32),
        
        'Sharpen': np.array([[0, -1, 0],
                             [-1, 5, -1],
                             [0, -1, 0]], dtype=np.float32),
        
        'Box Blur': np.ones((3, 3), dtype=np.float32) / 9,
        
        'Gaussian Blur': np.array([[1, 2, 1],
                                    [2, 4, 2],
                                    [1, 2, 1]], dtype=np.float32) / 16,
        
        'Sobel X': np.array([[-1, 0, 1],
                             [-2, 0, 2],
                             [-1, 0, 1]], dtype=np.float32),
        
        'Sobel Y': np.array([[-1, -2, -1],
                             [0, 0, 0],
                             [1, 2, 1]], dtype=np.float32),
        
        'Laplacian': np.array([[0, -1, 0],
                               [-1, 4, -1],
                               [0, -1, 0]], dtype=np.float32)
    }
    return filters

def benchmark():
    """اجرای بنچمارک برای مقایسه سرعت"""
    print("🚀 شروع بنچمارک Convolution با اسمبلی")
    print("=" * 50)
    
    # ایجاد نمونه
    conv = ConvolutionASM('./libconv.so')
    
    # ایجاد یک تصویر تست
    test_image = np.random.rand(512, 512).astype(np.float32) * 255
    print(f"📸 ابعاد تصویر تست: {test_image.shape}")
    
    # گرفتن فیلترها
    filters = create_test_filters()
    
    results = {}
    
    for name, kernel in filters.items():
        print(f"\n🧪 تست فیلتر: {name}")
        print(f"   ابعاد فیلتر: {kernel.shape}")
        
        # اندازه‌گیری زمان
        start = time.time()
        result = conv.convolve(test_image, kernel)
        end = time.time()
        
        elapsed = end - start
        results[name] = elapsed
        
        print(f"   ⏱️ زمان اجرا: {elapsed:.6f} ثانیه")
        print(f"   📊 min={result.min():.2f}, max={result.max():.2f}")
    
    print("\n" + "=" * 50)
    print("📊 خلاصه نتایج:")
    for name, t in results.items():
        print(f"   {name:20s}: {t:.6f} ثانیه")
    
    return results

def process_real_image(image_path, output_dir='./results'):
    """پردازش یک تصویر واقعی با همه فیلترها"""
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    conv = ConvolutionASM('./libconv.so')
    filters = create_test_filters()
    
    # بارگذاری تصویر
    img = Image.open(image_path).convert('L')
    img_array = np.array(img, dtype=np.float32)
    
    print(f"\n🖼️ پردازش تصویر: {image_path}")
    print(f"   ابعاد: {img_array.shape}")
    
    # ذخیره تصویر اصلی
    img.save(f"{output_dir}/00_original.jpg")
    
    for idx, (name, kernel) in enumerate(filters.items()):
        print(f"   🔄 اعمال {name}...")
        
        # اعمال فیلتر
        result, proc_time = conv.apply_filter(image_path, kernel, 
                                              f"{output_dir}/{idx+1:02d}_{name}.jpg")
        
        print(f"      ✅ زمان: {proc_time:.4f} ثانیه")

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1:
        # اگر آدرس تصویر داده شده
        process_real_image(sys.argv[1])
    else:
        # اجرای بنچمارک
        benchmark()
