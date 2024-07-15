Shader "Learning/Random1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RandomMultiplier("Random Multiplier", Range(100,100000)) = 100
        _Offset_X("_Offset_X", float) = 1.0
        _Offset_Y("_Offset_Y", float) = 1.0
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

            struct VertexData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _RandomMultiplier;
            float _Offset_X;
            float _Offset_Y;

            v2f vert (VertexData v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float random(float2 p)
            {
                float d = dot(p, float2(_Offset_X, _Offset_Y));
                float s = sin(d);
                return frac(s * 65124.6234125); // replace with Random Multiplier
            }

            float2 getTile(float2 gv, float rnd) // better not use if statements in shaders
            {
                if(rnd > 0.75)
                    gv = float2(1.0, 1.0) - gv;
                else if(rnd > 0.5)
                    gv = float2 (1.0 - gv.x, gv.y);
                else if (rnd > 0.25)
                    gv = 1.0 - float2(1.0 - gv.x, gv.y);

                return gv;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv * 10;
                float2 id = floor(uv);
                float2 gv = frac(uv);
                float rnd = random(id);
                float2 tile = getTile(gv, rnd);
                return fixed4(tile, 0, 1);
            }
            ENDCG
        }
    }
}
