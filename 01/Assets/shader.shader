Shader "Unlit/TestShader"{
    Properties {
        //_MainTex("Texture", 2D) = "white" {}
    }
    
    SubShader {
        Pass {
            CGPROGRAM
                #pragma vertex vertexFunction
                #pragma fragment fragmentFunction
                
                #include "UnityCG.cginc"
                
                struct appdata {
                    float4 vertex : POSITION;
                    float2 uv : TEXCOORD;
                };
                
                struct v2f {
                    float4 position: SV_POSITION;
                    float2 uv: TEXCOORD;
                };
                
                v2f vertexFunction(appdata IN) {
                    v2f OUT;
                    OUT.position = UnityObjectToClipPos(IN.vertex);
                    OUT.uv = IN.uv;
                    return OUT;
                }
                
                fixed4 fragmentFunction(v2f IN): SV_TARGET {
                    float2 uv = IN.uv;
                    float2 scaledUv = uv * 5 + sin(_Time.y);
                    float2 repeatedUv = frac(scaledUv);
                    repeatedUv -= 0.5;
                    
                    float circle = step(0.5, length(repeatedUv));
                    float3 color = fixed3(circle, circle, circle);
                    
                    float3 objectColor = fixed3(0.5, 0, 0.8);
                    float3 backgroundColor = fixed3(0.8, 0.2, 0.3);
                    
                    color = lerp(objectColor, backgroundColor, color);
                    
                    return fixed4(color, 1);
                }
            ENDCG
        }
    }
}

