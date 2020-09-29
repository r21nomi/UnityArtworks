Shader "Unlit/DigitalClock"
{
    Properties
    {
        _TexChars ("Characters", 2D) = "white" {}
        _CharacterCount_X ("CharacterCount_X", Float) = 8
        _CharacterCount_Y ("CharacterCount_Y", Float) = 2
        _Divide ("Divide", Float) = 4
        _Color ("Color", Color) = (1, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _TexChars;
            float4 _TexChars_ST;
            float _CharacterCount_X;
            float _CharacterCount_Y;
            float _Divide;
            float3 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                // o.uv = TRANSFORM_TEX(v.uv, _TexChars);
                o.uv = v.uv;
                return o;
            }

            float2 getNumber(float2 uv, float number)
            {
                float2 step = float2(1.0 / _CharacterCount_X, 1.0 / _CharacterCount_Y);
                float x = uv.x / _CharacterCount_X + step.x * (fmod(number, _CharacterCount_X));
                float y = uv.y / _CharacterCount_Y + step.y * (1.0 - fmod(floor(number / _CharacterCount_X), _CharacterCount_Y));
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
                    } else
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

            fixed4 frag (v2f i) : SV_Target
            {
                float2 t = getTime(i.uv, _Time.y);
                float4 col = tex2D(_TexChars, t);
                col.rgb -= (float3(1, 1, 1) - _Color);
                return col;
            }
            ENDCG
        }
    }
}
