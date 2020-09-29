Shader "Custom/DigitalClock2"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        [HDR] _EmissionColor ("Emission", Color) = (0,0,0,1)
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _TexChars ("Characters", 2D) = "white" {}
        _CharacterCount_X ("CharacterCount_X", Float) = 8
        _CharacterCount_Y ("CharacterCount_Y", Float) = 2
        _Divide ("Divide", Float) = 4
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _TexChars;
        float _CharacterCount_X;
        float _CharacterCount_Y;
        float _Divide;
        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        fixed4 _EmissionColor;
        float _Cutoff;

        struct Input {
            float2 uv_TexChars;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
        // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        float2 getNumber(float2 uv, float number)
        {
            float2 step = float2(1.0 / _CharacterCount_X, 1.0 / _CharacterCount_Y);
            float x = uv.x / _CharacterCount_X + step.x * (fmod(number, _CharacterCount_X));
            float y = uv.y / _CharacterCount_Y + step.y * (1.0 - fmod(floor(number / _CharacterCount_X),
                                                                      _CharacterCount_Y));
            return float2(x, y);
        }

        float2 getTime(float2 uv, float number)
        {
            float2 uvOrigin = uv;

            uv.x = fmod(uv.x * _Divide, 1);

            float2 result = float2(0, 0);
            // Left digit to right digit (i == 0 is 1st digit)
            for (int i = _Divide - 1; i >= 0; i--)
            {
                float p = pow(10, i);
                float num = 0;
                if (i == 0)
                {
                    // 1st digit
                    num = floor(frac(number / 10) * 10);
                }
                else
                {
                    num = floor(number / p);
                }
                float digitStep = 1.0 / _Divide;
                if (uvOrigin.x > digitStep * (_Divide - i - 1))
                {
                    result = getNumber(uv, num);
                }
            }

            return result;
        }

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float2 t = getTime(IN.uv_TexChars, _Time.y);
            float4 col = tex2D(_TexChars, t);
            o.Albedo = col.rgb;
            o.Emission = _EmissionColor * ((col.r + col.g + col.b) / 3);
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = col.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}