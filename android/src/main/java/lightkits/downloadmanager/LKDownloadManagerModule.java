package lightkits.downloadmanager;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.error.VolleyError;
import com.android.volley.request.DownloadRequest;
import com.android.volley.toolbox.Volley;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.io.File;

public class LKDownloadManagerModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public LKDownloadManagerModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "LKDownloadManager";
    }

    @ReactMethod
    public void download(final String url, String filePath,final Promise promise) {
        //
        final File toFile = new File(this.getReactApplicationContext().getApplicationContext().getCacheDir() + filePath);
        File dirAsFile = toFile.getParentFile();
        if(!dirAsFile.exists()){
            dirAsFile.mkdirs();
        }
        //
        RequestQueue mRequestQueue = Volley.newRequestQueue(this.getReactApplicationContext().getApplicationContext());

        DownloadRequest downloadRequest = new DownloadRequest(
                url,
                toFile.getAbsolutePath(),
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        promise.resolve(toFile.getAbsolutePath());
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        promise.reject("DOWNLOAD_ERROR", error);
                    }
                });
        //
        downloadRequest.setShouldCache(false);
        //
        mRequestQueue.add(downloadRequest);
    }
}

